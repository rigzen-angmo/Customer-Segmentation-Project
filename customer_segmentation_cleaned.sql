create database customer_segmentation_cleaned;
use customer_segmentation_cleaned;
show databases;
show tables;
show create table shopping_dataset_cleaned;
describe shopping_dataset_cleaned;

delimiter //
create procedure show_dataset()
begin
	select *
    from shopping_dataset_cleaned;
end //
delimiter ;

call show_dataset();

select * from shopping_dataset_cleaned;
select count(*) from shopping_dataset_cleaned;
select distinct(count(*)) from shopping_dataset_cleaned;

select distinct category
from shopping_dataset_cleaned;

select distinct itempurchased
from shopping_dataset_cleaned;

# which item purchased belongs to which category
select category, itempurchased, count(*) as total_purchased
from shopping_dataset_cleaned
group by category, itempurchased
order by category;

# checking missing/null value
select * from shopping_dataset_cleaned
where customerid is null;

# cleaned category column
alter table shopping_dataset_cleaned
add column cleaned_category varchar(50);

# insert into new column
update shopping_dataset_cleaned
set cleaned_category = case
	when itempurchased = "Phone" then "Electronics"
    when itempurchased = "Laptop" then "Electronics"
    when itempurchased = "Football" then "Sports"
    when itempurchased = "Watch" then "Accessories"
    when itempurchased = "Curtains" then "Home Decor"
    when itempurchased = "T-Shirt" then "Clothing"
    when itempurchased = "Shoes" then "Clothing"
    when itempurchased = "Bag" then "Accessories"
    else category
end
where itempurchased in 
	("Phone","Laptop","Football","Watch","Curtains","T-Shirt","Shoes","Bag");

# checking combinations
select cleaned_category, itempurchased, count(itempurchased) as total_purchase
from shopping_dataset_cleaned
group by cleaned_category, itempurchased
order by cleaned_category, total_purchase desc;

# checking missing/null value
select * from shopping_dataset_cleaned
where customerid is null;

select
	sum(case when customerid is null then 1 else 0 end) as customerid_null_value,
    sum(case when age is null then 1 else 0 end) as age_null_value,
    sum(case when gender is null then 1 else 0 end) as gender_null_value ,
    sum(case when itempurchased is null then 1 else 0 end) as purchased_null_value,
    sum(case when category is null then 1 else 0 end) as category_null_value,
    sum(case when purchaseamountusd is null then 1 else 0 end) as amount_null_value,
    sum(case when location is null then 1 else 0 end) location_null_value,
    sum(case when size is null then 1 else 0 end) size_null_value,
    sum(case when color is null then 1 else 0 end) color_null_value,
    sum(case when season is null then 1 else 0 end) season_null_value,
    sum(case when reviewrating is null then 1 else 0 end) as review_null_value,
    sum(case when subscriptionstatus is null then 1 else 0 end) subscription_null_value,
    sum(case when shippingtype is null then 1 else 0 end) as shipping_null_value,
    sum(case when discountapplied is null then 1 else 0 end) as discount_null_value,
    sum(case when promocodeused is null then 1 else 0 end) as pomocode_null_value,
    sum(case when previouspurchases is null then 1 else 0 end) as previouspurchase_null_value,
    sum(case when paymentmethod is null then 1 else 0 end) as payment_null_value,
    sum(case when frequencyofpurchases is null then 1 else 0 end) as freqPurchase_null_value,
    sum(case when cleaned_category is null then 1 else 0 end) as cleaned_category
from shopping_dataset_cleaned;

#checking empty space
select
    sum(case when gender = " " then 1 else 0 end) as genderEmptySpace,
    sum(case when itempurchased = " " then 1 else 0 end) as purchasedEmptySpace,
    sum(case when category = " " then 1 else 0 end) as categoryEmptySpace,
    sum(case when location = " " then 1 else 0 end) locationEmptySpace,
    sum(case when size = " " then 1 else 0 end) sizeEmptySpace,
    sum(case when color = " " then 1 else 0 end) colorEmptySpace,
    sum(case when season = " " then 1 else 0 end) seasonEmptySpace,
    sum(case when subscriptionstatus = " " then 1 else 0 end) subscriptionEmptySpace,
    sum(case when shippingtype = " " then 1 else 0 end) as shippingEmptySpace,
    sum(case when discountapplied = " " then 1 else 0 end) as discountEmptySpace,
    sum(case when promocodeused = " " then 1 else 0 end) as pomocodeEmptySpace,
    sum(case when paymentmethod = " " then 1 else 0 end) as paymentEmptySpace,
    sum(case when frequencyofpurchases = " " then 1 else 0 end) as freqPurchaseEmptySpace,
    sum(case when cleaned_category = " " then 1 else 0 end) as cleaned_category
from shopping_dataset_cleaned;

# checking duplicate values
select customerid, age, gender, itempurchased, category, purchaseamountusd,
		location, size, color, season, ReviewRating, subscriptionstatus, 
        shippingtype, Discountapplied, promocodeused, previouspurchases, 
        paymentmethod, FrequencyOfPurchases, cleaned_category, count(*) as duplicate_value
from shopping_dataset_cleaned
group by customerid, age, gender, itempurchased, category, purchaseamountusd,
		location, size, color, season, ReviewRating, subscriptionstatus, 
        shippingtype, Discountapplied, promocodeused, previouspurchases, 
        paymentmethod, FrequencyOfPurchases, cleaned_category
having count(*)>1;

# unique age
select distinct age 
from shopping_dataset_cleaned
order by age;

# inconsistant gender
select distinct gender
from shopping_dataset_cleaned;

# unique category
select distinct category 
from shopping_dataset_cleaned;

# unique cleaned_category
select distinct cleaned_category
from shopping_dataset_cleaned;

# unique item purchased
select distinct itempurchased 
from shopping_dataset_cleaned;

# unique location
select distinct location
from shopping_dataset_cleaned;

# unique size
select distinct size 
from shopping_dataset_cleaned;

# unique colour
select distinct color 
from shopping_dataset_cleaned;

# unique season
select distinct season 
from shopping_dataset_cleaned;

# unique ReviewRating
select distinct ReviewRating
from shopping_dataset_cleaned
order by ReviewRating;

# unique subscriptionStatus
select distinct Subscriptionstatus 
from shopping_dataset_cleaned;

# unique shippingtype
select distinct ShippingType 
from shopping_dataset_cleaned;

# unique DiscountApplied
select distinct DiscountApplied 
from shopping_dataset_cleaned;

# unique PromoCodeUsed
select distinct PromoCodeUsed 
from shopping_dataset_cleaned;

# unique PaymentMethod
select distinct PaymentMethod 
from shopping_dataset_cleaned;

# unique FrequencyOfPurchases
select distinct FrequencyOfPurchases 
from shopping_dataset_cleaned;
 
# checks Extra Spaces
select gender 
from shopping_dataset_cleaned
where gender <> trim(gender);

# checks extra space in multiple columns

select *
from shopping_dataset_cleaned
where gender <> trim(gender) 
	or ItemPurchased <> trim(ItemPurchased) 
    or Category <> trim(Category) 
    or location <> trim(location) 
    or size <> trim(size)
    or color <> trim(color)
    or season <> trim(season)
    or SubscriptionStatus <> trim(SubscriptionStatus)
    or ShippingType <> trim(ShippingType)
    or DiscountApplied <> trim(DiscountApplied)
    or PromoCodeUsed <> trim(PromoCodeUsed)
    or PaymentMethod <> trim(PaymentMethod)
    or FrequencyOfPurchases <> trim(FrequencyOfPurchases)
    or cleaned_category <> trim(cleaned_category);
 
 # checks invalid numbers
select min(age) as minimum_age,
		max(age) as maximum_age,
        min(purchaseamountusd) as min_purchase,
        max(purchaseamountusd) as max_purchase,
        min(previouspurchases) as min_previousP,
        max(previouspurchases) as max_previousP,
        min(ReviewRating) as min_rating,
        max(ReviewRating) as max_rating        
from shopping_dataset_cleaned;

#EDA

# 1) How many records belong to each gender?
select gender, count(gender) as total
from shopping_dataset_cleaned
group by gender
order by total desc;

# ANALYZING DATA
# How many purchase has discount applied in each category?
select category, itempurchased, discountapplied, count(category) as total_purchase
from shopping_dataset_cleaned
group by category, itempurchased, discountapplied
order by total_purchase desc;

# discount applied on each category
select category, discountapplied, count(category) as total_purchase
from shopping_dataset_cleaned
group by category, discountapplied
order by category, total_purchase desc;

# unique age
select distinct age
from shopping_dataset_cleaned
order by age desc;

# how many customer belong to each age group
select count(*) as total_customer, 
case 
	when age between 18 and 25 then "18-25"
    when age  between 26 and 35 then "26-35"
    when age  between 36 and 45 then "36-45"
    when age  between 46 and 55 then "46-55"
    when age  between 56 and 64 then "56-64"
end as age_range,
case 
	when age between 18 and 25 then "Young"
    when age  between 26 and 35 then "Adult"
    when age  between 36 and 45 then "Middle-Aged"
    when age  between 46 and 55 then "Older"
    when age  between 56 and 64 then "Senior"
end as age_group
from shopping_dataset_cleaned
group by age_range,age_group
order by total_customer desc;

# seperate column for age group and age range

alter table shopping_dataset_cleaned
add column agerange varchar(20);

alter table shopping_dataset_cleaned
add column AgeGroup varchar (20);

# adding values into new column
update shopping_dataset_cleaned
set AgeRange = case
	when age between 18 and 25 then "18-25"
    when age between 26 and 35 then "26-35"
    when age between 36 and 45 then  "36-45"
    when age between 46 and 55 then "46-55"
    when age between 56 and 64 then "56-64"
else null
end,
	AgeGroup = case
	when age between 18 and 25 then "Young"
    when age between 26 and 35 then "Adult"
    when age between 36 and 45 then  "Middle-Aged"
    when age between 46 and 55 then "Older"
    when age between 56 and 64 then "Senior"
else null
end;

set sql_safe_updates = 0;

# show how many records belongs to each age group
select agerange, agegroup, count(*) as totalrecords
from shopping_dataset_cleaned
group by agerange, agegroup
order by totalrecords desc;

# which age group has the highest average purchase amount?
select agerange, agegroup, 
	count(*) as total_customer, 
    round(avg(purchaseamountusd),2) as avg_purchase_amt,
    round(sum(purchaseamountusd),2) as total_purchase_amt
from shopping_dataset_cleaned
group by agerange, agegroup
order by avg_purchase_amt desc;

# which age group uses discounts most frequently?
select agerange, agegroup, discountapplied,
	count(*) as total_purchase_records,
    round(sum(purchaseamountusd),2) as total_purchase_amt
from shopping_dataset_cleaned
where discountapplied = "yes"
group by  agerange, agegroup, discountapplied
order by total_purchase_records desc;

# which age group and gender combination has the highest average purchase amt?
select agerange, agegroup, gender,
	count(*) as total_purchase,
    round(sum(purchaseamountusd),2) as total_purchase_amt,
    round(avg(purchaseamountusd),2) as avg_purchase_amt
from shopping_dataset_cleaned
group by agerange, agegroup, gender
order by avg_purchase_amt desc;

#which product category generates the highest total purchase amount?
select cleaned_category, round(sum(purchaseamountusd),2) as total_purchase_amt, count(*) as total_purchases
from shopping_dataset_cleaned
group by cleaned_category
order by total_purchase_amt desc;

# from which individual items have the highest purchase amounts
select cleaned_category, itempurchased,  
	count(itempurchased) as total_purchase,sum(purchaseamountusd) as total_purchase_amt
from shopping_dataset_cleaned
group by cleaned_category, itempurchased
order by total_purchase_amt desc;


select cleaned_category,  
	count(*) as total_purchase,
	round(sum(purchaseamountusd),2) as total_purchase_amt
from shopping_dataset_cleaned
group by cleaned_category
order by total_purchase desc;

# How many purchase records belong to each FrequencyOfPurchases value, and which frequency occurs most often?
call show_dataset();

select frequencyofpurchases, 
	count(*) as total_purchase,
    round(sum(previouspurchases),2) as total_purchase_amount,
    round(avg(previouspurchases),2) as avg_purchase_amount    
from shopping_dataset_cleaned
group by frequencyofpurchases
order by total_purchase desc;


# how does subscription status relate to customer purchasing behaviour?
select subscriptionstatus, 
	count(*) as total_purchases, 
    round(sum(purchaseamountusd),2) as total_purchase_amt
from shopping_dataset_cleaned
group by subscriptionstatus
order by total_purchases;

# how many have subscription
select subscriptionstatus,
	count(subscriptionstatus) as total_subscribers
from shopping_dataset_cleaned
where subscriptionstatus = "yes";

# which payment method is used most frequently, and what is the total purchase amt for each payment method?
select paymentmethod, count(*) as total_payment_method, sum(purchaseamountusd) as total_purchase_amt
from shopping_dataset_cleaned
group by paymentmethod
order by total_payment_method desc;

# which payment method has the highest average purchase amount?
select paymentmethod, 
	count(*) total_purchase,
    round(sum(purchaseamountusd),2) as total_purchase_amt,
    round(avg(purchaseamountusd),2) as avg_purchase_amt
from shopping_dataset_cleaned
group by paymentmethod
order by avg_purchase_amt desc;

# how does credit and debit card spending vary across different age groups?
select agerange, agegroup,
		count(*) as total_purchase,
        round(sum(purchaseamountusd),2) as total_card_spendings,
        round(avg(purchaseamountusd),2) as avg_card_spendings
from shopping_dataset_cleaned
where paymentmethod in ("credit card","debit card")
group by agerange, agegroup
order by total_card_spendings desc;

# How does credit and debit card spending vary across different seasons?
select season,
count(*) as total_purchases,
round(sum(purchaseamountusd),2) as total_card_spending,
round(avg(purchaseamountusd),2) as avg_card_spending
from shopping_dataset_cleaned
where paymentmethod in ("credit card","debit card")
group by season
order by total_card_spending desc;

# card spending by location
select location,
count(*) as total_records,
round(sum(purchaseamountusd),2) as total_card_spending,
round(avg(purchaseamountusd),2) as avg_card_spending
from shopping_dataset_cleaned
where paymentmethod in ("credit card","debit card")
group by location
order by total_card_spending desc;


call show_dataset();

# do customers who use discounts have a higher total purchase amount than customers who don't use discounts
select discountapplied, 
	count(*) as purchase_records, 
	round(sum(purchaseamountusd),2) as total_amt_spend,
    round(avg(purchaseamountusd),2) as avg_amt_spend
from shopping_dataset_cleaned
group by discountapplied
order by purchase_records desc;

# for each category, how many purchase records had a discount applied and how many did not?
select cleaned_category, discountapplied, count(*) as total_purchase
from shopping_dataset_cleaned
group by cleaned_category, discountapplied
order by cleaned_category;

# which gender has the higher avg purchase amount
select gender, 
	count(*) as total_gender, 
    round(sum(purchaseamountusd),2) as total_purchase_amt,
    round(avg(purchaseamountusd),2) as avg_purchase_amt
from shopping_dataset_cleaned
group by gender
order by total_gender desc;

# which season has the highest total purchase amount?
select season, 
	count(*) as total_purchase, 
    round(sum(purchaseamountusd),2) as total_purchase_amt,
    round(avg(purchaseamountusd),2) as avg_purchase_amt
from shopping_dataset_cleaned
group by season
order by total_purchase_amt desc;

# do subscribed customers spend more on avg than non- subscribed customers?
select SubscriptionStatus,
	count(*) as total_purchase,
    round(sum(purchaseamountusd),2) as total_purchase_amt,
    round(avg(purchaseamountusd),2) as avg_purchase_amt
from shopping_dataset_cleaned
group by SubscriptionStatus
order by avg_purchase_amt desc;

# which product category performs best in each season
select cleaned_category, season, 
	count(*) as total_purchase,
    round(sum(purchaseamountusd),2) as total_purchase_amt
from shopping_dataset_cleaned
group by cleaned_category, season
order by season,total_purchase desc;

# which product item generates the highest total purchase amount?
select season, itempurchased, 
	count(*) as total_purchase,
    round(sum(purchaseamountusd),2) as total_purchase_amt,
    round(avg(purchaseamountusd),2) as avg_purchase_amt
from shopping_dataset_cleaned
group by season, itempurchased
order by season, total_purchase desc;

call show_dataset();
# which items are purchased most frequently?
select itempurchased, 
	count(*) as total_purchase,
    round(sum(purchaseamountusd),2) as total_purchase_amt,
    round(avg(purchaseamountusd),2) as avg_purchase_amt 
from shopping_dataset_cleaned
group by itempurchased
order by total_purchase desc;

# which product category has the highest average review rating
select cleaned_category, 
	count(*) as total_purchase,
    round(avg(reviewrating),2) as avg_rating
from shopping_dataset_cleaned
group by cleaned_category
order by avg_rating desc;

# which locations have the highest total purchase amt?
select location, 
	count(*) as total_purchase,
    round(sum(purchaseamountusd),2) as total_purchase_amt,
    round(avg(purchaseamountusd),2) as avg_purchase_amt
from shopping_dataset_cleaned
group by location
order by total_purchase_amt desc;

# which shipping type has the highest average purchase amount?
select shippingtype, 
	count(*) as total_purchase,
    round(sum(purchaseamountusd),2) as total_purchase_amt,
    round(avg(purchaseamountusd),2) as avg_purchase_amt
from shopping_dataset_cleaned
group by shippingtype
order by avg_purchase_amt desc;

# which payment method is commonly used by each age group?
select agerange, agegroup, paymentmethod, 
	count(*) as total_purchase
from shopping_dataset_cleaned
group by agerange, agegroup, paymentmethod
order by agegroup, total_purchase desc;



# do subscribed customers spend more on avg than non- subscribed customers?
select SubscriptionStatus,
	count(*) as total_purchase,
    round(sum(purchaseamountusd),2) as total_purchase_amt,
    round(avg(purchaseamountusd),2) as avg_purchase_amt
from shopping_dataset_cleaned
group by SubscriptionStatus
order by avg_purchase_amt desc;

# which season and product category combination generates the highest total purchase amount?
select season, cleaned_category,
	count(*) as total_purchase,
    round(sum(purchaseamountusd),2) as total_purchase_amt,
    round(avg(purchaseamountusd),2) as avg_purchase_amt
from shopping_dataset_cleaned
group by season, cleaned_category
order by total_purchase_amt desc;

# How do total and average purchase amounts differ between discounted and non-discounted purchases across product categories?
select cleaned_category, discountapplied,
count(*) as total_purchase,
round(sum(purchaseamountusd),2) as total_amt,
round(avg(purchaseamountusd),2) as avg_amt
from shopping_dataset_cleaned
group by cleaned_category, discountapplied
order by cleaned_category, discountapplied desc;

# which category has the largest positive difference in average purchase amount when a discount is applied?
select cleaned_category, 
round(avg
	(case when discountapplied = "yes"
		then purchaseamountusd end),2) as discount_avg,
round (avg
	(case when discountapplied = "no"
		then purchaseamountusd end),2) as no_discount_avg,
round
	(avg
    (case when discountapplied = "yes"
    then purchaseamountusd end)
    -
    avg(case when discountapplied = "no"
    then purchaseamountusd end),
    2
    ) as difference
        
from shopping_dataset_cleaned
group by cleaned_category
order by (difference) desc;

# which product categories have the highest total purchase amount when discounts are applied?
select cleaned_category, discountapplied,
count(*) as total_purchase,
round(sum(purchaseamountusd),2) as total_amount
from shopping_dataset_cleaned
where discountapplied = "yes"
group by cleaned_category, discountapplied
order by total_amount desc;

# Which products are purchased most often in each season, and which products generate the highest total purchase amount?
select season, cleaned_category,
	count(*) as total_purchase,
    round(sum(purchaseamountusd),2) as total_amt,
    round(avg(purchaseamountusd),2) as avg_amt
from shopping_dataset_cleaned
group by season, cleaned_category
order by season, total_amt desc;

# which individual item are purchased most often in each season,and 
# which product have the highest total purchase amount?
select season, itempurchased,
count(*) as total_purchase,
round(sum(purchaseamountusd),2) as total_purchase_amt,
round(avg(purchaseamountusd),2) as avg_purchase_amt
from shopping_dataset_cleaned
group by season, itempurchased
order by season, total_purchase desc;



call show_dataset();



    

 
