# frozen_string_literal: true

class Plan < ApplicationRecord
  has_many :purchases, dependent: :restrict_with_exception

  validates :name, uniqueness: true
  validates :name, :price, :value, presence: true
  validates :price, :value, numericality: { greater_than: 0 }

  class << self
    def statistics_by_days(year, month, plan_ids, stat_object = :subscriptions)
      column_names = plan_ids.map { |plan_id| "COALESCE(id_#{plan_id}, 0) as id_#{plan_id}" }
      column_cases = if stat_object == :subscriptions
                       plan_ids.map { |plan_id| "COUNT(CASE WHEN plans.id = #{plan_id} THEN 1 ELSE NULL END) AS id_#{plan_id}" }
                     else
                       plan_ids.map { |plan_id| "SUM(CASE WHEN plans.id = #{plan_id} THEN sub_purchases.price ELSE NULL END) AS id_#{plan_id}" }
                     end

      select_query = <<-SQL
        SELECT 'Ngày ' || d.day AS name, #{column_names.join(', ')}
        FROM generate_series(1, #{Date.new(year, month).end_of_month.day}) AS d(day)
        LEFT JOIN (
          SELECT EXTRACT(DAY FROM sub_purchases.created_at) AS day, #{column_cases.join(', ')}
          FROM (
            SELECT * FROM purchases
            WHERE EXTRACT(YEAR FROM purchases.created_at) = ? AND EXTRACT(MONTH FROM purchases.created_at) = ? AND purchases.expires_at IS NOT NULL) AS sub_purchases
          INNER JOIN plans ON sub_purchases.plan_id = plans.id
          GROUP BY EXTRACT(DAY FROM sub_purchases.created_at)
        ) AS sub ON d.day = sub.day
        ORDER BY d.day
      SQL

      connection.execute(sanitize_sql_array([select_query, year, month]))
    end

    def statistics_by_months(year, plan_ids, stat_object = :subscriptions)
      column_names = plan_ids.map { |plan_id| "COALESCE(id_#{plan_id}, 0) as id_#{plan_id}" }
      column_cases = if stat_object == :subscriptions
                       plan_ids.map { |plan_id| "COUNT(CASE WHEN plans.id = #{plan_id} THEN 1 ELSE NULL END) AS id_#{plan_id}" }
                     else
                       plan_ids.map { |plan_id| "SUM(CASE WHEN plans.id = #{plan_id} THEN sub_purchases.price ELSE NULL END) AS id_#{plan_id}" }
                     end

      select_query = <<-SQL
        SELECT 'Tháng ' || m.month AS name, #{column_names.join(', ')}
        FROM generate_series(1, 12) AS m(month)
        LEFT JOIN (
          SELECT EXTRACT(MONTH FROM sub_purchases.created_at) AS month, #{column_cases.join(', ')}
          FROM (SELECT * FROM purchases WHERE EXTRACT(YEAR FROM purchases.created_at) = ? AND purchases.expires_at IS NOT NULL) AS sub_purchases
          INNER JOIN plans ON sub_purchases.plan_id = plans.id
          GROUP BY EXTRACT(MONTH FROM sub_purchases.created_at)
        ) AS sub ON m.month = sub.month
        ORDER BY m.month
      SQL

      connection.execute(sanitize_sql_array([select_query, year]))
    end

    def statistics_by_years(plan_ids, stat_object = :subscriptions)
      column_names = plan_ids.map { |plan_id| "COALESCE(id_#{plan_id}, 0) as id_#{plan_id}" }
      column_cases = if stat_object == :subscriptions
                       plan_ids.map { |plan_id| "COUNT(CASE WHEN plans.id = #{plan_id} THEN 1 ELSE NULL END) AS id_#{plan_id}" }
                     else
                       plan_ids.map { |plan_id| "SUM(CASE WHEN plans.id = #{plan_id} THEN sub_purchases.price ELSE NULL END) AS id_#{plan_id}" }
                     end

      to = Date.current.year
      from = to - 9

      select_query = <<-SQL
        SELECT 'Năm ' || y.year AS name, #{column_names.join(', ')}
        FROM generate_series(#{from}, #{to}) AS y(year)
        LEFT JOIN (
          SELECT EXTRACT(YEAR FROM sub_purchases.created_at) AS year, #{column_cases.join(', ')}
          FROM (SELECT * FROM purchases WHERE EXTRACT(YEAR FROM purchases.created_at) >= #{from} AND EXTRACT(YEAR FROM purchases.created_at) <= #{to} AND purchases.expires_at IS NOT NULL) AS sub_purchases
          INNER JOIN plans ON sub_purchases.plan_id = plans.id
          GROUP BY EXTRACT(YEAR FROM sub_purchases.created_at)
        ) AS sub ON y.year = sub.year
        ORDER BY y.year
      SQL

      connection.execute(sanitize_sql_array([select_query]))
    end

    def filter(params)
      plans = all.order(id: :asc)

      if params[:query].present?
        query = params[:query].strip

        plans = plans.where('name ILIKE ?', "%#{query}%")
      end

      plans
    end
  end
end
