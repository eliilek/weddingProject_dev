class WelcomeController < ApplicationController
  def index
  	# @custom_notifications = Notification.all
 	@notifications_check = Event.where(["updated_at <= ?", 3.days.ago])
 	@notifications = Notification.all
  end

  def meetings
  	@events = Event.where("sales_meeting_box = ?", true)
  end

  def bands
    if params[:band_id]
      @bands_param = params[:band_id]
      @band = Band.find(params[:band_id])
    end
    @restrictions = Restriction.all
  	@saturdays = saturdays
  	@events = Event.all
    bookings = Booking.order('date')
    good_bookings = []
    bookings.each do |booking|
      if booking.event != nil and booking.event != "" and booking.event.status != "RELEASED" and booking.event.status != "RELEASED-BAB" and booking.event.status != "RELEASED-BADJ" and good_bookings.exclude?(booking.date)
        good_bookings << booking.date
      end
    end
    @bookings = good_bookings 
  end
end
