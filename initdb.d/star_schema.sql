
CREATE EXTERNAL TABLE `countrycode`(
  `country` string, 
  `alpha-2 code` string, 
  `alpha-3 code` string, 
  `numeric code` bigint, 
  `latitude` double, 
  `longitude` double)


CREATE EXTERNAL TABLE `countypopulation`(
  `id` string, 
  `id2` bigint, 
  `county` string, 
  `state` string, 
  `population estimate 2018` bigint)


CREATE EXTERNAL TABLE `enigma_jhu_enigma_jhu`(
  `fips` bigint, 
  `admin2` string, 
  `province_state` string, 
  `country_region` string, 
  `last_update` string, 
  `latitude` double, 
  `longitude` double, 
  `confirmed` bigint, 
  `deaths` bigint, 
  `recovered` bigint, 
  `active` string, 
  `combined_key` string)


CREATE EXTERNAL TABLE `hospital_beds_rearc_usa_hospital_beds`(
  `objectid` int COMMENT 'from deserializer', 
  `hospital_name` string COMMENT 'from deserializer', 
  `hospital_type` string COMMENT 'from deserializer', 
  `hq_address` string COMMENT 'from deserializer', 
  `hq_address1` string COMMENT 'from deserializer', 
  `hq_city` string COMMENT 'from deserializer', 
  `hq_state` string COMMENT 'from deserializer', 
  `hq_zip_code` string COMMENT 'from deserializer', 
  `county_name` string COMMENT 'from deserializer', 
  `state_name` string COMMENT 'from deserializer', 
  `state_fips` string COMMENT 'from deserializer', 
  `cnty_fips` string COMMENT 'from deserializer', 
  `fips` string COMMENT 'from deserializer', 
  `num_licensed_beds` int COMMENT 'from deserializer', 
  `num_staffed_beds` int COMMENT 'from deserializer', 
  `num_icu_beds` int COMMENT 'from deserializer', 
  `adult_icu_beds` int COMMENT 'from deserializer', 
  `pedi_icu_beds` double COMMENT 'from deserializer', 
  `bed_utilization` double COMMENT 'from deserializer', 
  `avg_ventilator_usage` double COMMENT 'from deserializer', 
  `potential_increase_in_bed_capac` int COMMENT 'from deserializer', 
  `latitude` double COMMENT 'from deserializer', 
  `longtitude` double COMMENT 'from deserializer')


CREATE EXTERNAL TABLE `state_abv`(
  `col0` string, 
  `col1` string)


CREATE EXTERNAL TABLE `states_daily`(
  `date` bigint, 
  `state` string, 
  `positive` bigint, 
  `probablecases` bigint, 
  `negative` bigint, 
  `pending` bigint, 
  `totaltestresultssource` string, 
  `totaltestresults` bigint, 
  `hospitalizedcurrently` bigint, 
  `hospitalizedcumulative` bigint, 
  `inicucurrently` bigint, 
  `inicucumulative` bigint, 
  `onventilatorcurrently` bigint, 
  `onventilatorcumulative` bigint, 
  `recovered` bigint, 
  `lastupdateet` string, 
  `datemodified` string, 
  `checktimeet` string, 
  `death` bigint, 
  `hospitalized` bigint, 
  `hospitalizeddischarged` bigint, 
  `datechecked` string, 
  `totaltestsviral` bigint, 
  `positivetestsviral` bigint, 
  `negativetestsviral` bigint, 
  `positivecasesviral` bigint, 
  `deathconfirmed` bigint, 
  `deathprobable` bigint, 
  `totaltestencountersviral` bigint, 
  `totaltestspeopleviral` bigint, 
  `totaltestsantibody` bigint, 
  `positivetestsantibody` bigint, 
  `negativetestsantibody` bigint, 
  `totaltestspeopleantibody` bigint, 
  `positivetestspeopleantibody` bigint, 
  `negativetestspeopleantibody` bigint, 
  `totaltestspeopleantigen` bigint, 
  `positivetestspeopleantigen` bigint, 
  `totaltestsantigen` bigint, 
  `positivetestsantigen` bigint, 
  `fips` bigint, 
  `positiveincrease` bigint, 
  `negativeincrease` bigint, 
  `total` bigint, 
  `totaltestresultsincrease` bigint, 
  `posneg` bigint, 
  `dataqualitygrade` string, 
  `deathincrease` bigint, 
  `hospitalizedincrease` bigint, 
  `hash` string, 
  `commercialscore` bigint, 
  `negativeregularscore` bigint, 
  `negativescore` bigint, 
  `positivescore` bigint, 
  `score` bigint, 
  `grade` string)


CREATE EXTERNAL TABLE `us_county`(
  `date` string, 
  `county` string, 
  `state` string, 
  `fips` bigint, 
  `cases` bigint, 
  `deaths` bigint)


CREATE EXTERNAL TABLE `us_daily`(
  `date` bigint, 
  `states` bigint, 
  `positive` bigint, 
  `negative` bigint, 
  `pending` bigint, 
  `hospitalizedcurrently` bigint, 
  `hospitalizedcumulative` bigint, 
  `inicucurrently` bigint, 
  `inicucumulative` bigint, 
  `onventilatorcurrently` bigint, 
  `onventilatorcumulative` bigint, 
  `datechecked` string, 
  `death` bigint, 
  `hospitalized` bigint, 
  `totaltestresults` bigint, 
  `lastmodified` string, 
  `recovered` string, 
  `total` bigint, 
  `posneg` bigint, 
  `deathincrease` bigint, 
  `hospitalizedincrease` bigint, 
  `negativeincrease` bigint, 
  `positiveincrease` bigint, 
  `totaltestresultsincrease` bigint, 
  `hash` string)


CREATE EXTERNAL TABLE `us_states`(
  `date` string, 
  `state` string, 
  `fips` bigint, 
  `cases` bigint, 
  `deaths` bigint)


CREATE EXTERNAL TABLE `us_total_latest`(
  `positive` bigint, 
  `negative` bigint, 
  `pending` bigint, 
  `hospitalizedcurrently` bigint, 
  `hospitalizedcumulative` bigint, 
  `inicucurrently` bigint, 
  `inicucumulative` bigint, 
  `onventilatorcurrently` bigint, 
  `onventilatorcumulative` bigint, 
  `recovered` bigint, 
  `hash` string, 
  `lastmodified` string, 
  `death` bigint, 
  `hospitalized` bigint, 
  `total` bigint, 
  `totaltestresults` bigint, 
  `posneg` bigint, 
  `notes` string)