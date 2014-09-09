ActiveRecord::Schema.define do
  self.verbose = false

  create_table :test_objects, :force => true do |t|
  	t.string :name
  	t.text :metadata
  end
end