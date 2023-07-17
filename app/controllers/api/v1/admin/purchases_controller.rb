class Api::V1::Admin::PurchasesController < AdministratorController
  before_action :set_purchase, except: %i[index create]

  def index
    purchases = Purchase.filter(params)

    paginate purchases,
             serializer: Admin::PurchaseSerializer
  end

  def show
    expose @purchase
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params.require(:purchase)
          .permit :effective_date,
                  :expiry_date
  end
end
