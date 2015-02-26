class RenameClientsToEmployees < ActiveRecord::Migration
  def up
    CustomField.where(type: "ClientCustomField").update_all(type: "EmployeeCustomField")
    Principal.where(type: "Client").update_all(type: "Employee")
  end
end
