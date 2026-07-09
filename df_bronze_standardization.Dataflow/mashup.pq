[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "bronze_cards_DataDestination", IsNewTarget = false], Settings = [Kind = "Manual", AllowCreation = false, ColumnSettings = [Mappings = {[SourceColumnName = "id", DestinationColumnName = "id"], [SourceColumnName = "client_id", DestinationColumnName = "client_id"], [SourceColumnName = "card_brand", DestinationColumnName = "card_brand"], [SourceColumnName = "card_type", DestinationColumnName = "card_type"], [SourceColumnName = "card_number", DestinationColumnName = "card_number"], [SourceColumnName = "expires", DestinationColumnName = "expires"], [SourceColumnName = "cvv", DestinationColumnName = "cvv"], [SourceColumnName = "has_chip", DestinationColumnName = "has_chip"], [SourceColumnName = "num_cards_issued", DestinationColumnName = "num_cards_issued"], [SourceColumnName = "credit_limit", DestinationColumnName = "credit_limit"], [SourceColumnName = "acct_open_date", DestinationColumnName = "acct_open_date"], [SourceColumnName = "year_pin_last_changed", DestinationColumnName = "year_pin_last_changed"], [SourceColumnName = "card_on_dark_web", DestinationColumnName = "card_on_dark_web"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared bronze_cards = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "bronze_cards", ItemKind = "Table"]}[Data],
  #"Added custom" = Table.AddColumn(#"Navigation 2", "Source_File", each "Dataflow Gen2 Ingestion"),
  #"Added custom 1" = Table.AddColumn(#"Added custom", "Record_Source", each "Global Trust Bank Core"),
  #"Added custom 2" = Table.AddColumn(#"Added custom 1", "Ingestion_Timestamp", each DateTime.LocalNow()),
  #"Changed column type" = Table.TransformColumnTypes(#"Added custom 2", {{"Ingestion_Timestamp", type datetime}}),
  #"Added custom 3" = Table.AddColumn(#"Changed column type", "Load_Batch_ID", each 1)
in
  #"Added custom 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "bronze_transactions_DataDestination", IsNewTarget = false], Settings = [Kind = "Manual", AllowCreation = false, ColumnSettings = [Mappings = {[SourceColumnName = "id", DestinationColumnName = "id"], [SourceColumnName = "date", DestinationColumnName = "date"], [SourceColumnName = "client_id", DestinationColumnName = "client_id"], [SourceColumnName = "card_id", DestinationColumnName = "card_id"], [SourceColumnName = "amount", DestinationColumnName = "amount"], [SourceColumnName = "use_chip", DestinationColumnName = "use_chip"], [SourceColumnName = "merchant_id", DestinationColumnName = "merchant_id"], [SourceColumnName = "merchant_city", DestinationColumnName = "merchant_city"], [SourceColumnName = "merchant_state", DestinationColumnName = "merchant_state"], [SourceColumnName = "zip", DestinationColumnName = "zip"], [SourceColumnName = "mcc", DestinationColumnName = "mcc"], [SourceColumnName = "errors", DestinationColumnName = "errors"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared bronze_transactions = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "bronze_transactions", ItemKind = "Table"]}[Data],
  #"Added custom" = Table.AddColumn(#"Navigation 2", "Source_File", each "Dataflow Gen2 Ingestion"),
  #"Added custom 1" = Table.AddColumn(#"Added custom", "Record_Source", each "Global Trust Bank Core"),
  #"Added custom 2" = Table.AddColumn(#"Added custom 1", "Ingestion_Timestamp", each DateTime.LocalNow()),
  #"Changed column type" = Table.TransformColumnTypes(#"Added custom 2", {{"Ingestion_Timestamp", type datetime}}),
  #"Added custom 3" = Table.AddColumn(#"Changed column type", "Load_Batch_ID", each 1)
in
  #"Added custom 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "bronze_users_DataDestination", IsNewTarget = false], Settings = [Kind = "Manual", AllowCreation = false, ColumnSettings = [Mappings = {[SourceColumnName = "id", DestinationColumnName = "id"], [SourceColumnName = "current_age", DestinationColumnName = "current_age"], [SourceColumnName = "retirement_age", DestinationColumnName = "retirement_age"], [SourceColumnName = "birth_year", DestinationColumnName = "birth_year"], [SourceColumnName = "birth_month", DestinationColumnName = "birth_month"], [SourceColumnName = "gender", DestinationColumnName = "gender"], [SourceColumnName = "address", DestinationColumnName = "address"], [SourceColumnName = "latitude", DestinationColumnName = "latitude"], [SourceColumnName = "longitude", DestinationColumnName = "longitude"], [SourceColumnName = "per_capita_income", DestinationColumnName = "per_capita_income"], [SourceColumnName = "yearly_income", DestinationColumnName = "yearly_income"], [SourceColumnName = "total_debt", DestinationColumnName = "total_debt"], [SourceColumnName = "credit_score", DestinationColumnName = "credit_score"], [SourceColumnName = "num_credit_cards", DestinationColumnName = "num_credit_cards"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared bronze_users = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "bronze_users", ItemKind = "Table"]}[Data],
  #"Added custom" = Table.AddColumn(#"Navigation 2", "Source_File", each "Dataflow Gen2 Ingestion"),
  #"Added custom 1" = Table.AddColumn(#"Added custom", "Record_Source", each "Global Trust Bank Core"),
  #"Added custom 2" = Table.AddColumn(#"Added custom 1", "Ingestion_Timestamp", each DateTime.LocalNow()),
  #"Changed column type" = Table.TransformColumnTypes(#"Added custom 2", {{"Ingestion_Timestamp", type datetime}}),
  #"Added custom 3" = Table.AddColumn(#"Changed column type", "Load_Batch_ID", each 1)
in
  #"Added custom 3";
shared bronze_users_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "bronze_users", ItemKind = "Table"]}[Data]
in
  TableNavigation;
shared bronze_transactions_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "bronze_transactions", ItemKind = "Table"]}[Data]
in
  TableNavigation;
shared bronze_cards_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "bronze_cards", ItemKind = "Table"]}[Data]
in
  TableNavigation;
