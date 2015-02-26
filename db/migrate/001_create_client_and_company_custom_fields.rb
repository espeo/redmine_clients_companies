class CreateClientAndCompanyCustomFields < ActiveRecord::Migration
  def up
    CompanyCustomField.create({
      name: "WWW",
      field_format: "string",
    })

    CompanyCustomField.create({
      name: "Phone",
      field_format: "string",
    })

    CompanyCustomField.create({
      name: "Address",
      field_format: "text",
    })

    EmployeeCustomField.create({
      name: "WWW",
      field_format: "string",
    })

    EmployeeCustomField.create({
      name: "Phone",
      field_format: "string",
    })

    EmployeeCustomField.create({
      name: "Address",
      field_format: "text",
    })
  end

  def down

  end
end
