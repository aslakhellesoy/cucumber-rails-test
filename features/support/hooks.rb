After('@clean_lorries_afterwards') do
  Lorry.destroy_all
end