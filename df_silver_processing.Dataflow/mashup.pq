[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "silver_cards_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared silver_cards = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "bronze_cards", ItemKind = "Table"]}[Data],
  #"Capitalized each word" = Table.TransformColumns(#"Navigation 2", {{"has_chip", each Text.Proper(_), type nullable text}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Capitalized each word", {{"card_number", Int64.Type}, {"expires", type date}, {"cvv", Int64.Type}, {"num_cards_issued", Int64.Type}, {"acct_open_date", type date}, {"year_pin_last_changed", type date}})
in
  #"Changed column type";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "silver_transactions_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared silver_transactions = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "bronze_transactions", ItemKind = "Table"]}[Data],
  #"Capitalized each word" = Table.TransformColumns(#"Navigation 2", {{"merchant_city", each Text.Proper(_), type nullable text}}),
  #"Filtered rows" = Table.SelectRows(#"Capitalized each word", each ([merchant_state] <> null))
in
  #"Filtered rows";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "silver_customers_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared silver_customers = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "bronze_users", ItemKind = "Table"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 2", {{"current_age", Int64.Type}}),
  #"Added custom" = Table.AddColumn(#"Changed column type", "Age_Validation_Flag", each if [current_age] < 20 then "Review" else "Valid")
in
  #"Added custom";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "silver_customer_cards_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared silver_customer_cards = let
  Source = Table.NestedJoin(silver_cards, {"client_id"}, silver_customers, {"id"}, "bronze_users", JoinKind.LeftOuter),
  #"Expanded bronze_users" = Table.ExpandTableColumn(Source, "bronze_users", {"yearly_income", "total_debt", "credit_score"}, {"yearly_income", "total_debt", "credit_score"})
in
  #"Expanded bronze_users";
shared silver_customers_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "silver_customers", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared silver_cards_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "silver_cards", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared silver_customer_cards_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "silver_customer_cards", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared silver_transactions_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "2ac0a272-b27d-4918-b5e3-46392c5d2bf7"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6cfc8354-d31c-4fde-93f9-e4579ddfae80"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "silver_transactions", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
