class Members
  def initialize
    @member_list = {}

    @member_list['android'] = {
        :email    => 'xjohndoeandroid@gmail.com',
        :password => '9987',
        :name     => 'John Doe Android',
    }

    @member_list['ios'] = {
        :email => 'xjohndoeios@gmail.com',
        :password => '9987',
        :name => 'John Doe iOS',
    }

  end

  def get(name)
    @member_list[name]
  end
end