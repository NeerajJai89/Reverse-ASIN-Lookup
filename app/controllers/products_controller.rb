class ProductsController < ApplicationController
  def index
    @products = Product.all.paginate(page: params[:page],per_page: 10)
  end

  def create
    @product = Product.where(:asin => create_params[:asin]).first
    if @product.present?
      redirect_to product_url(@product)
   else
    product = Product.new(product_hash)
    if product.save
        flash[:notice] = "Product successfully saved!"
        redirect_to product_url(product)
      else
        p 'inside here the fated error'
        flash[:alert] = "Sorry, we can't locate this product"
        redirect_back(fallback_location: products_url)
      end
    end
    
  end

  def show
    @product ||= query_db(create_params[:id])
    #@product ||= Product.where(:asin => create_params[:asin]).first
  end

  private

  def query_db(asin)
    prd = Product.where(:asin => asin).first
  end

  def create_params
    params.permit(:asin,:id,:page)
  end

  def product_hash
    #query_db(create_params[:asin])
    @product_hash ||= ScraperService.new(asin: create_params[:asin]).scrape
  end
end
