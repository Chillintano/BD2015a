class GenerationController < ApplicationController

  def genAll()
    srand(1) #remove this in release, it keeps random from being random
    options = {
        "clients" => 5,
        "workers" => 10,
        "objects" => 15,
        "products" => 30,
        "objectMinDuration" => 3,
        "objectMaxDuration" => 15,
        "minDealPayment" => 20000,
        "maxDealPayment" => 200000,
        "minMonthPayment" => 10000,
        "maxMonthPayment" => 35000,
        "productsPerObjectMin" => 5,
        "productsPerObjectMax" => 15,
        "productVolumeMin" => 5,
        "productVolumeMax" => 300,
        "productPriceMin" => 10,
        "productPriceMax" => 500,
        "workersPerObjectMin" => 4,
        "workersPerObjectMax" => 20,
        "workersMinDuration" => 1,
        "workersMaxDuration" => 8,
        "databaseDuration" => 60,
        "minObjectsInReportPeriod" => 3
    }
    a=[1,2,3,4,5]

    puts "azazaz"
    genClients(options)
    genWorkers(options)
    genObjects(options)
    genProducts(options)
    genForemen(options)
    genRepairProducts(options)
    genAssignments(options)
    genTransactions(options)
  end

  def genClients(options)
    Client.delete_all
    for i in 1..options['clients'].to_i do
      Client.create(name: "Client " + i.to_s)
    end
  end

  def genWorkers(options)
    Worker.delete_all
    for i in 1..options['workers'].to_i do
      Worker.create(name: "Worker " + i.to_s)
    end
  end

  def genProducts(options)
    Product.delete_all
    for i in 1..options['products'].to_i do
      Product.create(description: "Product " + i.to_s)
    end
  end

  def genObjects(options)
    RepairObject.delete_all

    clients_db = Client.all.order('id')
    for i in 1..options['objects'].to_i do
      client_rand = rand(options['clients'])
      duration = options['objectMinDuration'] + rand(options['objectMaxDuration'] - options['objectMinDuration'])
      finish = rand(options['databaseDuration'] - duration)
      date_start = Time.new((Time.now.year - ((duration+finish)/12) ), 1 + (Time.now.month - ((duration+finish)%12) + 12)%12, 1+rand(28))
      if (Time.now.month-((duration+finish)%12) < 0)
        date_start = Time.new(date_start.year-1,date_start.month,date_start.day)
      end
      date_finish = Time.new(Time.now.year - (finish/12), 1 + (Time.now.month - (finish%12) + 12)%12, 1+rand(28))
      RepairObject.create(description: "Object " + i.to_s, client_id: clients_db[client_rand].id, date_started:date_start.strftime("%Y%m%d"), date_finished:date_finish.strftime("%Y%m%d"))
    end
  end

  def genForemen(options)
    Foreman.delete_all

    workers_db = Worker.all.order('id')
    for i in 1..options['objects'].to_i do
      worker_rand = rand(options['workers'])
      Foreman.create(worker_id: workers_db[worker_rand].id, repair_object_id: i)
    end
  end

  def genRepairProducts(options)
    RepairProduct.delete_all

    objects_db = RepairObject.all.order('id')
    products_db = Product.all.order('id')
    for i in 0..options['objects']-1
      numRepairProducts = options['productsPerObjectMin'] + rand(options['productsPerObjectMax'] - options['productsPerObjectMin'])
      products_subset = products_db.sample(numRepairProducts)
      products_subset.each do |t|
        vol = options['productVolumeMin'] + rand(options['productVolumeMax'] - options['productVolumeMin'])
        RepairProduct.create(product_id: t.id, repair_object_id: objects_db[i].id, volume: vol)
      end

    end
  end

  def genAssignments(options)
    Assignment.delete_all

    objects_db = RepairObject.all.order('id')
    workers_db = Worker.all.order('id')
    for i in 0..options['objects']-1
      numWorkers = options['workersPerObjectMin'] + rand(options['workersPerObjectMax'] - options['workersPerObjectMin'])
      workers_subset = workers_db.sample(numWorkers)

      objectDuration = (objects_db[i].date_finished.year - objects_db[i].date_started.year)*12 + (objects_db[i].date_finished.month - objects_db[i].date_started.month)


      workers_subset.each do |t|
        duration = options['workersMinDuration'] + rand([objectDuration,options['workersMaxDuration']].min - options['workersMinDuration'])
        start = rand(objectDuration - duration)
        date_start = Time.new(objects_db[i].date_started.year + start/12, 1 + (objects_db[i].date_started.month + (start%12) + 12)%12, 1+rand(28))
        if ((objects_db[i].date_started.month + (start%12)) > 12)
          date_start = Time.new(date_start.year+1, date_start.month, date_start.day)
        end

        date_finish = Time.new(objects_db[i].date_started.year + (start+duration)/12, 1 + (objects_db[i].date_started.month + ((start+duration)%12) + 12)%12, 1+rand(28))
        if ((objects_db[i].date_started.month + (start%12)) > 12)
          date_finish = Time.new(date_finish.year+1, date_finish.month, date_start.day)
        end

        workerType = rand()
        if (workerType<0.25)
          payment = options['minDealPayment'] + rand(options['maxDealPayment'] - options['minDealPayment'])
          workerType = false
        else
          payment = options['minMonthPayment'] + rand(options['maxMonthPayment'] - options['minMonthPayment'])
          workerType = true
        end
        Assignment.create(worker_id: t.id, repair_object_id: objects_db[i].id, date_started: date_start.strftime("%Y%m%d"), date_finished: date_finish.strftime("%Y%m%d"), pay: payment, isTimed: workerType)
      end

    end
  end

  def genTransactions(options)
    products_db = RepairProduct.all.order('id')
    products_db.each do |t|
      payment_parts = 1 + rand(5)
      payment_proportions = Array.new

      if (payment_parts == 1)
        payment_proportions << 1
      else
        for i in 1..payment_parts-1
          payment_proportions << rand()*(1-payment_proportions.sum)
        end
        payment_proportions << 1-payment_proportions.sum
      end

      value_for_each = options['productPriceMin'] + rand(options['productPriceMax'] - options['productPriceMin'])

      payment_proportions.each do |y|
        volume_in_part = (t.volume*y).ceil
        Transaction.create(income: false, client_id: t.repair_object.client.id, repair_object_id: t.repair_object.id, product_id: t.product.id, value: volume_in_part*value_for_each, volume: volume_in_part, description: "Product " + t.product.id.to_s + " for object " + t.repair_object.id.to_s + ", volume: " + volume_in_part.to_s + " price per each:" + value_for_each.to_s)
      end

    end

    assignments_db = Assignment.all.order('id')
    assignments_db.each do |t|
      if (t.isTimed == true)
        months_working  = (t.date_finished.year - t.date_started.year)*12 + (t.date_finished.month - t.date_started.month) + 1
        for i in 1..months_working
          Transaction.create(income: false, client_id: t.repair_object.client.id, repair_object_id: t.repair_object.id, product_id: nil, value: t.pay, volume: nil, description: "Monthly payment for " + t.worker.name)
        end
      else
        Transaction.create(income: false, client_id: t.repair_object.client.id, repair_object_id: t.repair_object.id, product_id: nil, value: t.pay, volume: nil, description: "One-time payment for " + t.worker.name)
      end
    end


  end
end
