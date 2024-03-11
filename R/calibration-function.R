calibration=
  function(
    eval_df
    ,boot=30
  ){
    eval_df_bin=
      eval_df %>%
      mutate(pred=round(pred,1))
    
    calib_plot_df=
      eval_df_bin %>%
      group_by(pred) %>%
      summarize(
        true=mean(obs==levels(obs)[2])
        ,se=qnorm(0.975)*sd(obs==levels(obs)[2])/sqrt(n())
        ,lb=true-se
        ,ub=true+se
      )
    
    calib_plot=
      calib_plot_df %>%
      ggplot(aes(pred,true)) +
      geom_abline(slope=1,intercept=0,lty=2) +
      geom_linerange(aes(ymin=lb,ymax=ub)) +
      geom_point() +
      geom_smooth(method='lm',formula=y~x,color='black',na.rm=T) +
      coord_equal() +
      scale_x_continuous(limits=0:1,breaks=seq(0,1,0.1)) +
      scale_y_continuous(limits=0:1,breaks=seq(0,1,0.1)) +
      theme_classic()
    
    calib_dist=
      eval_df_bin %>%
      group_by(obs,pred) %>%
      summarize(n=n(),.groups='drop') %>%
      ggplot(aes(pred,n)) +
      geom_col(width=0.075,) +
      facet_grid(obs~.,scales='free_y') +
      scale_x_continuous(limits=c(-0.1,1.1),breaks=seq(0,1,0.1)) +
      scale_y_continuous(trans='log10') +
      theme_classic()
    
    set.seed(1)
    calib_metrics=
      calib_plot_df %>%
      lm(true~pred,data=.) %>%
      tidy() %>%
      mutate(term=c('intercept','slope')) %>%
      mutate(ci=qnorm(0.975)*std.error) %>%
      select(-std.error,-statistic,-p.value) %>%
      rbind(
        eval_df %>%
          mutate(sqr_error=(pred-as.integer(obs==levels(obs)[2]))^2) %>%
          pull(sqr_error) %>%
          sapply(X=seq(boot),Y=.,function(X,Y)
            Y %>%
              .[sample(seq(length(.)),length(.),T)] %>%
              mean() %>%
              sqrt()
          ) %>%
          data.frame(term='rmse',rmse=.) %>%
          group_by(term) %>%
          summarize(
            estimate=mean(rmse)
            ,ci=qnorm(0.975)*sd(rmse)/sqrt(n())
            ,.groups='drop'
          )
      )
    
    list(
      plot=calib_plot
      ,dist=calib_dist
      ,metrics=calib_metrics
    )
  }