class HistoriesController < ApplicationController
	before_action :set_history, only: [:show, :edit, :update, :destroy]

	def index
		@histories = History.all
	end

	def show
	end

	def create
		tags = params["history"]["tag"].split
		for t in tags
    	@history = History.new({tag: t})
    	@history.save
    end
		respond_to do |format|
      format.html { render nothing: true }
      format.json { render nothing: true }
    end
  end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tags
      params.require(:history).find(:tag)
    end
end