# frozen_string_literal: true

require_relative '../shared/data_manager/load_data'
require_relative '../shared/data_manager/save_data'

# Contruct input file path
input_file_path = File.join(__dir__, 'data/input.json')

# Load data
rentals = LoadData.load_data(input_file_path)

# Calculate Rental Prices
output = { rentals: [] }

rentals.each do |rental|
  output[:rentals] << { id: rental.id, options: rental.display_options,
                        actions: rental.display_credit_debit_with_options }
end

# Save Results to output.json
output_file_path = File.join(__dir__, 'data/output.json')
SaveData.save_data(output_file_path, output)