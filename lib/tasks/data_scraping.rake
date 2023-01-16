namespace :data_scraping do
  require 'open-uri'
  require 'nokogiri'
  require 'net/http'

  def scaping_categories
    url = 'https://www.nettruyenup.com'
    uri = URI.parse(url)

    response = Net::HTTP.get_response(uri)
    html = response.body
    doc = Nokogiri::HTML(html)

    element = doc.css('.dropdown-menu').first
    element = element.css('a[title]')

    categories = element.map do |e|
      { name: e['title'], description: e['data-title'] }
    end
  end

  def scraping_commic(url:, category_schema: nil)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    html = response.body
    doc = Nokogiri::HTML(html)

    comic = {}

    info_e = doc.css('.detail-info').first
    img_e = info_e.css('img').first

    comic[:name] = info_e.css('img').first['alt']
    comic[:image] = Image.new(url: "https://#{info_e.css('img').first['src'][2..-1]}")

    comic[:other_names] = info_e.css('.other-name').first
    comic[:other_names] = comic[:other_names]? comic[:other_names].text : ''

    comic[:author] = info_e.css('.author').first.css('p').last.text.strip

    comic[:status] = info_e.css('.status').first.css('p').last.text

    if category_schema.nil?
      comic[:category_ids] = info_e.css('.kind').first.css('a').map { |e| e.text }
    else
      comic[:category_ids] = info_e.css('.kind').first.css('a').map do |a|
        category_schema[a.text]
      end

      comic[:category_ids] = comic[:category_ids].compact
    end

    comic[:description] = doc.css('.detail-content').first.css('p').text
    comic[:chapters] = doc.css('.list-chapter').first.css('li').map do |e|
      Chapter.new(
        name: e.css('a').first.text,
        images: [
          Image.new(url: 'https://pbs.twimg.com/media/FUKMh_RaUAAUY1Y?format=jpg&name=large'),
          Image.new(url: 'https://pbs.twimg.com/media/Fhp0gMsaEAADbeg?format=jpg&name=900x900'),
          Image.new(url: 'https://pbs.twimg.com/media/FaQC7fXaQAANOdX?format=jpg&name=900x900')
        ]
      )
    end

    comic
  end

  def scraping_commics(page: 1, category_schema: nil)
    url = "https://www.nettruyenup.com/tim-truyen?page=#{page}"
    uri = URI.parse(url)

    response = Net::HTTP.get_response(uri)
    html = response.body
    doc = Nokogiri::HTML(html)

    comics = []

    items_element = doc.css('.items').first
    item_elements = items_element.css('.item')

    for item_element in item_elements
      comics << scraping_commic(url: item_element.css('a').first['href'], category_schema: category_schema)
    end

    comics
  end

  def scraping_commics_pages(pages:, category_schema: nil)
    comics = []

    for page in pages
      comics.concat(scraping_commics(page: page, category_schema: category_schema))
    end

    comics
  end

  desc "categories"
  task categories: :environment do
    Category.import(scaping_categories)
  end

  task commics: :environment do
    category_schema = Category.all.map { |c| [c[:name], c[:id]] }
    category_schema = category_schema.to_h

    comics = scraping_commics_pages(pages: 1..10, category_schema: category_schema)

    for c in comics
      Comic.create!(c)
    end
  end
end
