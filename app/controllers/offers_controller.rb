class OffersController < ApplicationController
    skip_before_action :authenticate_request
    before_action :admin_authenticate_request
    before_action :set_offer, only: [:destroy, :update]

    def index
        @offers = Offer.all
        render json: @offers, status: :ok
    end

    def create
        @offer = Offer.create(offer_params)
        render json: @offer, status: :ok
    end

    def update
        @offer.update!(offer_params) if @offer
        render json: @offer, status: :ok
    end

    def destroy
        @offer.destroy if @offer
        render json: @offer, status: :ok
    end

    private
        def offer_params
            params.permit(:item_id, :discount_rate, :offer_type, :required_item_id)
        end

        def set_offer
            @offer = Offer.find(params[:id])
        end
end
