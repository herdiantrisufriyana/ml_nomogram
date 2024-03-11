binarize_var=
  \(data
    ,data_sum
  ){
    data %>%
      mutate_all(as.character) %>%
      mutate(seq=seq(nrow(.))) %>%
      gather(variable,category,-seq) %>%
      left_join(
        data_sum %>%
          mutate_all(as.character) %>%
          filter(!category%in%c('(Other)',"NA's"))
        ,by=join_by(variable,category)
      ) %>%
      mutate(
        category=
          ifelse(
            is.na(freq)
            ,'otherNAs'
            ,category
          )
      ) %>%
      select(-freq) %>%
      mutate_at('variable',str_remove_all,'_') %>%
      unite(variable_category,variable,category,sep='_') %>%
      mutate(
        variable_category=
          variable_category %>%
          factor(unique(.))
        ,value=1
      ) %>%
      rbind(
        setdiff(
          data_sum %>%
            filter(!category%in%c('(Other)',"NA's")) %>%
            group_by(variable) %>%
            arrange(
              variable %>%
                factor(unique(.))
              ,category
            ) %>%
            ungroup() %>%
            mutate_at('variable',str_remove_all,'_') %>%
            unite(variable_category,variable,category,sep='_') %>%
            pull(variable_category)
          ,pull(.,variable_category)
        ) %>%
          data.frame(variable_category=.) %>%
          mutate(
            seq=NA
            ,value=0
          )
      ) %>%
      spread(variable_category,value,,fill=0) %>%
      select_at(
        data_sum %>%
          filter(!category%in%c('(Other)',"NA's")) %>%
          group_by(variable) %>%
          arrange(
            variable %>%
              factor(unique(.))
            ,category
          ) %>%
          ungroup() %>%
          mutate_at('variable',str_remove_all,'_') %>%
          unite(variable_category,variable,category,sep='_') %>%
          pull(variable_category)
      ) %>%
      select(-outcome_benign) %>%
      rename(outcome=outcome_malignant)
  }