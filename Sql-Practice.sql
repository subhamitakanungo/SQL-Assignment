SELECT * FROM moviesdb.movies where industry="Bollywood";
select count(*) from moviesdb.movies where industry="Bollywood";
select count(*) from moviesdb.movies where industry="Hollywood";
select distinct industry from moviesdb.movies;
select * from moviesdb.movies where title like "%THOR%";
select * from moviesdb.movies where studio="";
select * from moviesdb.movies where imdb_rating>=9;
select * from moviesdb.movies where imdb_rating>6 and imdb_rating<=8;
select count(*) from moviesdb.movies where imdb_rating>6 and imdb_rating<=8;
select * from moviesdb.movies where imdb_rating between 6 and 8; #line 8 & 10 have same result
select count(*) from moviesdb.movies where imdb_rating between 6 and 8; 
select * from moviesdb.movies where release_year=2022 or release_year=2019;
select * from moviesdb.movies where release_year in (2022,2019); #line 12 & 13 are same
select * from moviesdb.movies where studio in ("Marvel Studios","Zee Studios");
select * from moviesdb.movies where imdb_rating IS NULL;
select * from moviesdb.movies where industry="Bollywood" order by imdb_rating;
select * from moviesdb.movies where industry="Bollywood" order by imdb_rating desc;
select * from moviesdb.movies where industry="Bollywood" order by imdb_rating limit 5;
select * from moviesdb.movies where industry="Bollywood" order by imdb_rating limit 5 offset 1; #It will retrive data from the 2nd position
select * from moviesdb.movies where industry="Bollywood" order by imdb_rating limit 6 offset 4;
##Functions in SQL
select count(*) from moviesdb.movies where industry="Bollywood";
select max(imdb_rating) from moviesdb.movies where industry="Bollywood";
select min(imdb_rating) from moviesdb.movies where industry="Bollywood";
select avg(imdb_rating) from moviesdb.movies where studio="Marvel Studios";
select round(avg(imdb_rating),2) from moviesdb.movies where studio="Marvel Studios";
select round(avg(imdb_rating),2) as avg_rating from moviesdb.movies where studio="Marvel Studios";
select min(imdb_rating) as min_rating,max(imdb_rating) as max_rating,
round(avg(imdb_rating),2) as avg_rating from moviesdb.movies where studio="Marvel Studios";
select industry,count(*) from moviesdb.movies group by industry;
select industry,studio,count(*) from moviesdb.movies group by studio;
select industry,studio,count(*) from moviesdb.movies group by industry;
select studio,count(*) from moviesdb.movies group by studio;
select studio,count(*) as cnt from moviesdb.movies group by studio order by cnt ;
select industry,count(industry) as cnt,avg(imdb_rating) as avg_rating from moviesdb.movies group by industry;
select industry,count(industry) as cnt,avg(imdb_rating) as avg_rating from moviesdb.movies group by industry order by cnt desc;
select studio,count(studio) as cnt,avg(imdb_rating) as avg_rating from moviesdb.movies group by studio order by avg_rating desc;
select studio,count(studio) as cnt,avg(imdb_rating) as avg_rating from moviesdb.movies where studio!="" group by studio order by avg_rating desc;

##having clause and calculated column
#from--> where--> group by--> having--> order by
#print all the yrs where more than two movies are released
select release_year,count(*) from moviesdb.movies group by release_year;
select release_year,count(release_year) from moviesdb.movies group by release_year; #it will count only non-null values in release_year row
select release_year,count(*) as cnt from moviesdb.movies group by release_year order by cnt ;
select release_year,count(*) as cnt from moviesdb.movies where cnt>2 group by release_year order by cnt ; #It will not work so will use having
select release_year,count(*) as cnt from moviesdb.movies group by release_year having cnt>2 order by cnt ;
select release_year,count(*) as cnt from moviesdb.movies group by release_year having imdb_rating>2 order by cnt ; #this query won't work as having clause will extract the details if that particular column name is present in select statement
select release_year,count(*) as cnt from moviesdb.movies where imdb_rating >6 group by release_year having cnt>2 order by cnt ; #bt it will work for where clause

#Calculated columns
#How to get current date in SQL?
SELECT CURDATE();
#If we need only year:
SELECT year(CURDATE());

select *from moviesdb.actors;
select *,year(CURDATE()) from moviesdb.actors;

#How to calculate Age of actors
select *,(year(CURDATE())-birth_year) as age from moviesdb.actors;

#Calculate Profit
select *,(revenue-budget) as profit from moviesdb.financials;

#currency coversion to INR
select *,
if (currency="USD",revenue*83.88,revenue)as revenue_INR
from moviesdb.financials;

#Unit conversion (Billions=millions*1000) Please follow below rule as we need to covert the unit into milions
#Billions=rev*1000
#Thousands=rev/1000
#Millions=rev
select distinct unit from moviesdb.financials;

select*,
	case
		when unit="Billions" Then revenue*1000
		when unit="Thousands" Then revenue/1000
        when unit="Millions" Then revenue
	End as revenue_mln
from moviesdb.financials;

#Alternate Method
select*,
	case
		when unit="Billions" Then revenue*1000
		when unit="Thousands" Then revenue/1000
        Else revenue
	End as revenue_mln
from moviesdb.financials;

#Join
#Q: Generate a report having movie title,budget,revenue,etc
select movie_id,budget,revenue,unit,title  #will get error as movie_id is ambiguous means it is present in both the table so system unable to indeties which table we are refereing to
from moviesdb.movies
join moviesdb.financials
on movies.movie_id=financials.movie_id;
#correct answer
select movies.movie_id,budget,revenue,unit,title
from moviesdb.movies
join moviesdb.financials # if will write only join, by default it represents inner join which takes only common values from both the tables
on movies.movie_id=financials.movie_id;
#Alternate way
select movies.movie_id,budget,revenue,unit,title
from moviesdb.financials
join moviesdb.movies
on movies.movie_id=financials.movie_id;

#To make query shorter we can execute the query as below
select m.movie_id,budget,revenue,unit,title
from moviesdb.financials f
join moviesdb.movies m
on m.movie_id=f.movie_id;

#Left join- Query all the movie_id and title available in left table
select movies.movie_id,budget,revenue,unit,title
from moviesdb.movies #the table which is present in from clause , by default it will be left table and other will be right table
left join moviesdb.financials
on movies.movie_id=financials.movie_id;

#Right join- Query all the movie_id and title available in left table
select movies.movie_id,budget,revenue,unit,title
from moviesdb.movies
right join moviesdb.financials
on movies.movie_id=financials.movie_id; #but if we will go to the last row, we can't see the movie ids because we have taken movie_id w.r.t movie table.
#revised query
select financials.movie_id,budget,revenue,unit,title
from moviesdb.movies
right join moviesdb.financials
on movies.movie_id=financials.movie_id;

#Full Join - This is combination of both left and right join so I copied above two queries and add UNION in between these two queriesj
select movies.movie_id,budget,revenue,unit,title from moviesdb.movies
left join moviesdb.financials
on movies.movie_id=financials.movie_id
union
select financials.movie_id,budget,revenue,unit,title from moviesdb.movies
right join moviesdb.financials
on movies.movie_id=financials.movie_id;

#left join,right join,full join are called as outer join
#example- if we will write right join as right outer join, the query will work.
select financials.movie_id,budget,revenue,unit,title from moviesdb.movies
right outer join moviesdb.financials
on movies.movie_id=financials.movie_id;

#Example-JOIN ON MULTIPLE COLUMNS (We can use multiple common columns to join two tables)
select financials.movie_id,budget,revenue,unit,title from moviesdb.movies
right outer join moviesdb.financials
on movies.movie_id=financials.movie_id and movies.col_nm=financials.col_nm;

# "using" clause in join
select movie_id,budget,revenue,unit,title from moviesdb.movies #no need to meantion table name for movie_id
right join moviesdb.financials
using(movie_id); #It will work when common column has same name in both the tables otherwise will use ON

select movie_id,budget,revenue,unit,title from moviesdb.movies #no need to meantion table name for movie_id
left join moviesdb.financials
using(movie_id); # we can add multiple columns also