tidy_raw_data=
  \(data
    ,outcome_var
    ,excluded_var=c()
  ){
    data %>%
      rename_at(outcome_var,\(x)'outcome') %>%
      select_at(
        colnames(.) %>%
          .[!.%in%excluded_var]
      ) %>%
      rename_all(str_to_lower) %>%
      rename_all(str_replace_all,'\\.+','_') %>%
      select(outcome,everything()) %>%
      `rownames<-`(NULL)
  }