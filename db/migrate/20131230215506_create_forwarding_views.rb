class CreateForwardingViews < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("CREATE VIEW `forwarding_users` AS select `m`.`email` AS `email`,`m`.`alias` AS `alias` from `members` `m` WHERE `m`.`email` IS NOT NULL AND `m`.`alias` IS NOT NULL;")
    ActiveRecord::Base.connection.execute("CREATE VIEW `forwarding_groups` AS select `m`.`alias` AS `email`, `ou`.`email` AS `alias` from (`members` `m` join `organisational_units` `ou` on((`m`.`organisational_unit_id` = `ou`.`id`))) WHERE `ou`.`email` IS NOT NULL AND `m`.`alias` IS NOT NULL;")
    ActiveRecord::Base.connection.execute("CREATE VIEW `forwarding_functions` AS select `m`.`alias` AS `email`,`f`.`email` AS `alias` from (`members` `m` join `member_functions` `f` on((`m`.`functions_mask` & `f`.`mask`))) WHERE `f`.`email` IS NOT NULL AND `m`.`alias` IS NOT NULL;")
    ActiveRecord::Base.connection.execute(
      <<-SQL
        CREATE VIEW `forwarding_generic` AS
          SELECT `ff`.`email` AS `email`, `ff`.`alias` AS alias FROM `forwarding_functions` `ff` WHERE `ff`.`email` IS NOT NULL
          UNION
          SELECT `fu`.`email` AS `email`, `fu`.`alias` AS alias FROM `forwarding_users` `fu` WHERE `fu`.`email` IS NOT NULL
          UNION
          SELECT `fg`.`email` AS `email`, `fg`.`alias` AS alias FROM `forwarding_groups` `fg` WHERE `fg`.`email` IS NOT NULL;
      SQL
    )
    ActiveRecord::Base.connection.execute(
      <<-SQL
        CREATE VIEW `forwarding` AS
          SELECT `fg`.`email` AS `email`, `fg`.`alias` AS alias FROM `forwarding_generic` `fg` WHERE `fg`.`email` IS NOT NULL
          UNION
          SELECT `fa`.`email` AS `email`, `fa`.`alias` AS alias FROM `mail_aliases` `fa` WHERE `fa`.`email` IS NOT NULL;
      SQL
    )
  end

  def down
  end
end
