class Factory
  @factories = {}

  class << self 
    def add(name, klass, &block)
      @factories[name] = [klass, block]
    end

    def create(name)
      new(name).tap(&:save!)
    end

    def new(name)
      factory = @factories[name]
      factory[0].new.tap { |obj| factory[1].call(obj) }
    end
  end
end




class User
  attr_accessor :name

  def initialize
    @name = "John"
  end

  def save!
    puts "Saved"
  end
end



Factory.add(:user, User) do |user|
  user.name = rand(200).to_s 
end


50.times do
  p Factory.create(:user)
end
