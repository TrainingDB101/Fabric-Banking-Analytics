[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared silver_cards = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "silver_cards", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
shared silver_customer_cards = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "silver_customer_cards", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
shared silver_customers = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "silver_customers", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
shared silver_transactions = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "silver_transactions", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "dim_customer_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared dim_customer = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "silver_customers", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"id", "customer_key"}, {"yearly_income", "Income"}, {"total_debt", "debt"}, {"num_credit_cards", "number_of_cards"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"customer_key", Int64.Type}, {"retirement_age", Int64.Type}, {"birth_month", Int64.Type}, {"birth_year", Int64.Type}, {"number_of_cards", Int64.Type}, {"credit_score", Int64.Type}, {"debt", Currency.Type}, {"Income", Currency.Type}, {"per_capita_income", Currency.Type}}),
  #"Removed columns" = Table.RemoveColumns(#"Changed column type", {"address", "latitude", "longitude"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed columns", {{"current_age", "current_ages"}})
in
  #"Renamed columns 1";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "dim_card_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared dim_card = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "silver_cards", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"id", "card_key"}, {"client_id", "customer_key"}, {"card_on_dark_web", "dark_web_flag"}}),
  #"Removed columns" = Table.RemoveColumns(#"Renamed columns", {"card_number", "expires", "cvv"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Removed columns", {{"card_key", Int64.Type}, {"customer_key", Int64.Type}, {"credit_limit", Currency.Type}}),
  #"Renamed columns 1" = Table.RenameColumns(#"Changed column type", {{"card_type", "card_types"}})
in
  #"Renamed columns 1";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "fact_transactions_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared fact_transactions = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "silver_transactions", ItemKind = "Table"]}[Data],
  #"Renamed columns" = Table.RenameColumns(#"Navigation 2", {{"id", "transaction_key"}, {"client_id", "customer_key"}, {"card_id", "card_key"}, {"date", "transaction_date"}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Renamed columns", {{"amount", Currency.Type}, {"transaction_key", Int64.Type}, {"customer_key", Int64.Type}, {"card_key", Int64.Type}})
in
  #"Changed column type";
shared dim_customer_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "dim_customer", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared dim_card_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "dim_card", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared fact_transactions_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "fact_transactions", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
