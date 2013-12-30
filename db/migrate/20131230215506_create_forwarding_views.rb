class CreateForwardingViews < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("CREATE VIEW `forwarding_users` AS select `members`.`email` AS `email`,`members`.`login` AS `alias` from `members`;")
    ActiveRecord::Base.connection.execute("CREATE VIEW `forwarding_groups` AS select `m`.`email` AS `email`,lcase(concat(`ou`.`name`,'@pfadismn.ch')) AS `alias` from (`members` `m` join `organisational_units` `ou` on((`m`.`organisational_unit_id` = `ou`.`id`)));")
    ActiveRecord::Base.connection.execute("CREATE VIEW `forwarding_functions` AS select `m`.`email` AS `email`,`f`.`email` AS `alias` from (`members` `m` join `member_functions` `f` on((`m`.`functions_mask` & `f`.`mask`)));")
    ActiveRecord::Base.connection.execute("CREATE VIEW `forwarding` AS select `ff`.`email` AS `email`,`ff`.`alias` AS `f_alias`,`fu`.`alias` AS `u_alias`,`fg`.`alias` AS `g_alias`,`fa`.`alias` AS `a_alias` from ((`forwarding_functions` `ff` left join `forwarding_users` `fu` on((`ff`.`email` = `fu`.`email`))) left join `forwarding_groups` `fg` on((`ff`.`email` = `fg`.`email`)) left join mail_aliases fa on ((`ff`.`email` = `fa`.`email`)));")
  end

  def down
  end
end
