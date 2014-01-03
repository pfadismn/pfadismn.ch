class CreateMemberFunctions < ActiveRecord::Migration
  def up
    create_table :member_functions do |t|
      t.string :name
      t.string :email
      t.integer :mask
    end

    MemberFunction.reset_column_information
    MemberFunction::FUNCTIONS.each_with_index do |f, i|
      f = f.to_s.downcase
      m = MemberFunction.create!({name: f, email: "#{f}@pfadismn.ch", mask: 2**i})
    end
  end

  def down

  end
end
