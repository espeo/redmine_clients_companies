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

    ClientCustomField.create({
      name: "WWW",
      field_format: "string",
    })

    ClientCustomField.create({
      name: "Phone",
      field_format: "string",
    })

    ClientCustomField.create({
      name: "Address",
      field_format: "text",
    })
  end

  def down

  end
end
