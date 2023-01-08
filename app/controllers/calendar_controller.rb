class CalendarController < ApplicationController

  
    def week
        @meetings_periode = Meeting.where(
            start_time: Time.now.beginning_of_month.beginning_of_week..
            Time.now.end_of_month.end_of_week)
    end
  
    def month
        @meetings_periode = Meeting.where(
            start_time: Time.now.beginning_of_month.beginning_of_week..
            Time.now.end_of_month.end_of_week)
    end
  end
  