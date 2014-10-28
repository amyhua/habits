class HistoriesController < ApplicationController
	before_action :set_history, only: [:edit, :update, :destroy]

	def index
		@histories = History.all
	end

	def show
    @history = History.new
    @histories = History.all
    @today = History.today
	end

	def create
		tags = params["history"]["tag"].split(',')
		tags.each do |t|
    	@history = History.new({
        tagday: Time.now.to_date.to_s,
        tag: Time.now.to_date.to_s + '|' + t,
        tagline: t
      })
    	@history.save
    	# saves unique histories that are unique by the Day
    end
		respond_to do |format|
      format.html { render nothing: true }
      format.json { render nothing: true }
    end
  end

  def json
    uniq_taglines = History.all.map { |h| h["tagline"] }.uniq

    tags2 = History.all
    all_tags = History.all.map { |h| {
      tagday: h["tagday"],
      tagline: h["tagline"] }
    }


    stage1 = uniq_taglines.map do |tagline|
      { tagline: tagline,
        tagdays: all_tags.map { |h| h[:tagday] if h[:tagline] == tagline }
          .compact
      }
    end

  	tags = History.all.map { |h| h["tag"] }
  	respond_to do |format|
  		format.json { render json: stage1 }
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