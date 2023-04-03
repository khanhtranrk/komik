class Api::V1::Admin::CategoriesController < AdministratorController
  before_action :set_category, except: %i[index create]

  def index
    categories = Category.filter(params)

    paginate categories,
             serializer: Admin::CategoriesSerializer
  end

  def show
    expose @category
  end

  def create
    category = Category.create! category_params

    expose
  end

  def update
    @category.update!(category_params)

    expose
  end

  def destroy
    @category.destroy!

    expose
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category)
          .permit :name,
                  :description
  end
end
