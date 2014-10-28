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

    all_tags = History.all.map { |h| {
      tagday: h["tagday"],
      tagline: h["tagline"] }
    }


    stage1 = uniq_taglines.map do |tagline|
      { 
        tagline: tagline,
        tagdays: all_tags.map { |h| h[:tagday] if h[:tagline] == tagline }
          .compact
      }
    end

    stage2 = stage1.map do |tag|
      {
        tagday: tag[:tagdays][0],
        tagline: tag[:tagline],
        size: tag[:tagdays].length
      }
    end

    stage3 = stage2.chunk { |day| 1.day.ago.to_date.to_s if day[:tagday] == 1.day.ago.to_date.to_s }
      .map do |date, ary| 
        {
          date: date,
          group: ary.map { |h| { tagline: h[:tagline], size: h[:size] } }
        }
      end

  	tags = History.all.map { |h| h["tag"] }
  	respond_to do |format|
  		format.json { render json: stage3 }
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