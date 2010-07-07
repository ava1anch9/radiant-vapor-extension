class Admin::FlowMetersController < ApplicationController
  only_allow_access_to :index, :create, :destroy,
    :when => :admin,
    :denied_url => { :controller => 'pages', :action => 'index' },
    :denied_message => t('vapor.errors.must_be_admin')
  
  def index
    @flow_meter = FlowMeter.new
    @flow_meters = FlowMeter.find(:all)
  end
  
  def create
    @flow_meter = FlowMeter.create!(params[:flow_meter])
    redirect_to admin_flow_meters_url
  rescue ActiveRecord::RecordInvalid => e
    flash[:error] = "#{e.message}"
    redirect_to admin_flow_meters_url
  rescue FlowMeter::DataMismatch => e
    flash[:error] = "#{e.message}"
    redirect_to admin_flow_meters_url
  end
  
  def destroy
    @flow_meter = FlowMeter.find(params[:id])
    @flow_meter.destroy
    flash[:notice] = t('vapor.redirect_destroyed')
    redirect_to admin_flow_meters_url
  end
end
