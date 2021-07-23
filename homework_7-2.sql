/* Выведите список товаров products и разделов catalogs, который соответствует товару. */

select p.id 
     , c.name as catalog_name
     , p.name as product_name
     , p.price 
     , p.description      
from products p 
  inner join catalogs c 
    on p.catalog_id = c.id;
