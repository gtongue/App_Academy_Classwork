class BandsController < ApplicationController
    def new
        render :new
    end

    def create
        band = Band.create(band_params)
        redirect_to bands_url
    end

    def show
        @band = Band.find(params[:id])
        render :show
    end

    def index
        @bands = Band.all
        render :index
    end
    
    def destroy

    end

    def edit

    end

    def update

    end

    private
    
    def band_params
        params.require(:band).permit(:name)
    end
end