discrimination=
  function(
    eval_df
    ,boot=30
  ){
    source('R/compute_metrics-function.R')
    
    disc_plot=
      eval_df %>%
      compute_metrics(p=F,ppv=F,npv=F,nb=F,interp=F) %>%
      .$metrics %>%
      select(th,tpr,tnr) %>%
      ggplot(aes(tnr,tpr)) +
      geom_abline(slope=1,intercept=1,lty=2) +
      geom_path() +
      geom_point() +
      geom_text(
        aes(label=round(th,2))
        ,hjust=-0.1
        ,vjust=1.1
        ,size=3
        ,check_overlap=T
      ) +
      coord_equal() +
      scale_x_reverse(breaks=seq(0,1,0.1)) +
      scale_y_continuous(breaks=seq(0,1,0.1)) +
      theme_classic()
    
    set.seed(1)
    disc_metrics=
      seq(boot) %>%
      lapply(function(x){
        eval_df %>%
          .[sample(seq(nrow(.)),nrow(.),T),] %>%
          compute_metrics(p=F,ppv=F,npv=F,nb=F,interp=F) %>%
          .$metrics %>%
          mutate(boot=x)
      }) %>%
      do.call(rbind,.) %>%
      select(-th) %>%
      group_by(boot) %>%
      arrange(tnr,tpr) %>%
      mutate(seq=seq(n())) %>%
      ungroup() %>%
      rename(x=tnr,y=tpr) %>%
      left_join(
        slice(.,-1) %>%
          mutate(seq=seq-1) %>%
          rename(x2=x,y2=y)
        ,by=c('boot','seq')
      ) %>%
      mutate(
        auc=
          0.5*(x2-x)*(y-y2)+
          (x2-x)*y2
      ) %>%
      group_by(boot) %>%
      summarize(auc=sum(auc,na.rm=T),.groups='drop') %>%
      summarize(
        term='AUC-ROC'
        ,estimate=mean(auc)
        ,ci=qnorm(0.975)*sd(auc)/sqrt(n())
      )
    
    list(
      plot=disc_plot
      ,metrics=disc_metrics
    )
  }