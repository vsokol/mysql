/* (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. 
 * Выведите список рейсов flights с русскими названиями городов.
 */

-- Вариант 1
select fl.id
     , ifnull(cf.name, fl.`from`) as `from`
     , ifnull(ct.name, fl.`to`) as `to`
from flights fl
   left join cities cf
     on fl.`from` = cf.label
   left join cities ct
     on fl.`to` = ct.label;

-- Вариант 2
select fl.id
     , ifnull(( select f.name
                from cities f
                where fl.`from` = f.label ), fl.`from` ) as `from`
     , ifnull(( select t.name
                from cities t
                where fl.`to` = t.label ), fl.`to`) as `to`
from flights fl;

