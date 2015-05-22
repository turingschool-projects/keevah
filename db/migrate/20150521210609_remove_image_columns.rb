class RemoveImageColumns < ActiveRecord::Migration
  def change
    remove_column :loan_requests, :image_file_name
    remove_column :loan_requests, :image_content_type
    remove_column :loan_requests, :image_file_size
    remove_column :loan_requests, :image_updated_at
    add_column :loan_requests, :image_url, :string, :default => "http://www.kiva.org/img/w632/1847429.jpg"
  end
end
