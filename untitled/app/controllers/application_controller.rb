class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  #Количество клиентов
  $client_count = 5
  #Количество рабочих
  $workers_count = 10
  #KOKOKO
  $resources_min = 30
  #Минимальное число объектов
  $object_min = 15
  #Стоимость работ по 1 объекту
  $cost_min = 100000
  $cost_max = 10000000
  #KOKOKO
  $deal_payment_min = 20000
  $deal_payment_max = 200000
  #KOKOKO
  $month_payment_min = 10000
  $month_payment_max = 35000
  #Кол-во необходимых материалов на объект
  $resources_count_min = 5
  $resources_count_max = 15
  #Объем материалов
  $resources_total_min = 5
  $resources_total_max = 300
  #Цена материала
  $resources_price_min = 10
  $resources_price_max = 500
  #KOKOKO
  $workers_min = 4
  $workers_max = 20
  #KOKOKO
  $workers_time_min = 1
  $workers_time_max = 8
  #Продолжительность работ по объекту
  $time_min = 3
  $time_max = 15
  #Временной охват данных
  $data_time_total = 60
  #Период времени (в месяцах)
  $time_total = 12
  #процент прибыли == 1 или фиксированной суммой == 1-1
  $state = 1
  #Значение процент прибыли или фиксированной суммой
  $value = 10


  def index
    #nothing
  end

  def saveOptions
    $client_count = params["client_count"].to_i
    $workers_count = params["workers_count"].to_i
    $object_min = params["object_min"].to_i
    $resources_min = params["resources_min"].to_i
    $cost_min = params["cost_min"].to_i
    $cost_max = params["cost_max"].to_i
    $resources_count_min = params["resources_count_min"].to_i
    $resources_count_max = params["resources_count_max"].to_i
    $resources_total_min = params["resources_total_min"].to_i
    $resources_total_max = params["resources_total_max"].to_i
    $resources_price_min = params["resources_price_min"].to_i
    $resources_price_max = params["resources_price_max"].to_i
    $deal_payment_min = params["deal_payment_min"].to_i
    $deal_payment_max = params["deal_payment_max"].to_i
    $month_payment_min = params["month_payment_min"].to_i
    $month_payment_max = params["month_payment_max"].to_i
    $workers_min = params["workers_min"].to_i
    $workers_max = params["workers_max"].to_i
    $workers_time_min = params["workers_time_min"].to_i
    $workers_time_max = params["workers_time_max"].to_i
    $time_min = params["time_min"].to_i
    $time_max = params["time_max"].to_i
    $data_time_total = params["data_time_total"].to_i

    redirect_to :controller => 'application', :action => 'index'
  end

  def generate
    $time_total = params["time_total"].to_i
    $state = params["state"].to_i
    $value = params["value"].to_i

    redirect_to :controller => 'generation', :action => 'genAll'
  end
end
