class PagesController < ApplicationController

  def index
    if request.post?
      @day = Date.parse(params[:day])
    else
      @day = Line.first.created_at.to_date
    end
    @lines = Line.where(created_at: @day..@day.next_day).order(created_at: :asc)
    @highlighted_speaker = @lines.first.speaker
  end

  def upload
    if request.post?
      log_data = params[:log_file]

      # Process line by line!
      log_data.read.each_line do |line|
        Line.create_from_input(line)
      end
    end
  end
end