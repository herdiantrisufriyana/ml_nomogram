decision=
  function(
    eval_df
    ,boot=30
  ){
    source('R/compute_metrics-function.R')
    
    dec_plot=
      eval_df %>%
      compute_metrics(p=F,tpr=F,tnr=F,ppv=F,npv=F,interp=F) %>%
      .$metrics %>%
      select(th,nb) %>%
      # filter(th<=mean(eval_df$obs==levels(eval_df$obs)[2])*2) %>%
      ggplot(aes(th,nb)) +
      
      geom_hline(yintercept=0,lty=2) +
      annotate('text',0,0,label='treat none',hjust=0,vjust=-0.4,size=3) +
      geom_abline(
        slope=-1
        ,intercept=mean(eval_df$obs==levels(eval_df$obs)[2])
        ,lty=2
      ) +
      annotate(
        'text'
        ,0
        ,mean(eval_df$obs==levels(eval_df$obs)[2])
        ,angle=-50
        ,label='treat all'
        ,hjust=-0.4
        ,vjust=1.4
        ,size=3
      ) +
      geom_path() +
      geom_point() +
      scale_x_continuous(breaks=seq(0,1,0.01)) +
      scale_y_continuous(breaks=seq(0,1,0.01)) +
      theme_classic()
    
    set.seed(1)
    dec_metrics=
      seq(boot) %>%
      lapply(function(x){
        eval_df %>%
          .[sample(seq(nrow(.)),nrow(.),T),] %>%
          compute_metrics(tpr=F,tnr=F,ppv=F,npv=F,interp=F) %>%
          .$metrics %>%
          mutate(boot=x)
      }) %>%
      do.call(rbind,.) %>%
      group_by(boot,p) %>%
      arrange(th,nb) %>%
      mutate(seq=seq(n())) %>%
      ungroup() %>%
      rename(x=th,y=nb) %>%
      left_join(
        slice(.,-1) %>%
          mutate(seq=seq-1) %>%
          rename(x2=x,y2=y)
        ,by=c('boot','p','seq')
      ) %>%
      mutate(
        auc=
          0.5*(x2-x)*(y-y2)+
          (x2-x)*y2
      ) %>%
      group_by(boot,p) %>%
      summarize(auc=sum(auc,na.rm=T),.groups='drop') %>%
      mutate(auc=(auc-0.5*p^2)/p) %>%
      summarize(
        term='Net% AUC-DC'
        ,estimate=mean(auc)
        ,ci=qnorm(0.975)*sd(auc)/sqrt(n())
      )
    
    list(
      plot=dec_plot
      ,metrics=dec_metrics
    )
  }