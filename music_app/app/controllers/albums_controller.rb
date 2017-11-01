class AlbumsController < ApplicationController
    def new
        # render json: params
        @bands = Band.all
        render :new
    end

    def create
        album = Album.new(album_params)
        album.year = Time.now.year
        album.save
        redirect_to band_url(album.band_id)
    end

    def show
        @album = Album.find(params[:id])
        render :show
    end
    
    def destroy

    end

    def edit

    end

    def update

    end
    
    private
    def album_params
        params.require(:album).permit(:title, :band_id, :live)
    end
end
