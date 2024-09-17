![2024-09-17_14-58-08](https://github.com/user-attachments/assets/78d230c5-121d-4ff8-9cef-643a7e9a7a1d)

# Задания по модулю "SQL для работы с базами данных в PostgreSQL"
<h2> Первые пять задач написание SELECT запросов к таблице sales в базе данных coffe_shop. </h2> 

1. Вывести все параметры, относящиеся к покупкам, которые совершал Calvin Potter
![image](https://github.com/user-attachments/assets/bb580beb-b60b-47b2-ae95-8c3d745421c0)

2. Посчитать средний чек по дням

![image](https://github.com/user-attachments/assets/9500bc5f-a05f-4194-a0d1-3d8456c9f8f4)

4. Преобразуйте дату транзакции в нужный формат: год, месяц, день. Приведите названия продуктов к стандартному виду в нижнем регистре

![image](https://github.com/user-attachments/assets/ed20dedc-d2b1-4b5a-894e-cd19da115b05)

5. Сделать анализ покупателей и разделить их по категориям. Посчитать количество транзакций, сделанных каждым покупателем. Разделить их на категории: Частые гости (>= 23 транзакций), Редкие посетители (< 10 транзакций), Стандартные посетители (все остальные)

![image](https://github.com/user-attachments/assets/9bff0edb-7cd3-421b-958c-23aa56a09f07)

6. Посчитать количество уникальных посетителей в каждом магазине каждый день

![image](https://github.com/user-attachments/assets/4d2a9684-4587-4a38-88dd-e320eb217a3b)

<h2>Задачи 6-10 проверяют темы: отношения таблиц (JOIN), агрегация, оконные функции.</h2>
<p><em>Запросы не должны обращаться к таблице coffe_shop.sales, а должны обращаться к данным из других таблиц. Напишите запросы в оптимальном применении синтаксиса.</em></p>

6. Посчитать количество клиентов по поколениям

![image](https://github.com/user-attachments/assets/676de001-77b6-4dc7-b979-4d7da4d4f147)

7. Найдите топ 10 самых продаваемых товаров каждый день и проранжируйте их по дням и кол-ву проданных штук

![image](https://github.com/user-attachments/assets/4d411915-ba4c-4425-a9fd-417ba4b53380)

8. Выведите только те названия регионов, в которых продавался продукт “Columbian Medium Roast”, с последней датой продажи

![image](https://github.com/user-attachments/assets/a2534127-5143-4e9c-9548-9ed1a2bbffe3)

9. Соберите витрину следующего вида:

![image](https://github.com/user-attachments/assets/ed49dc2f-d2b2-41a8-bf4a-7159af0fa166)

10. Найдите разницу между максимальной и минимальной ценой товара в категории

![image](https://github.com/user-attachments/assets/b8902149-3bae-47d1-9354-d57e8c3dc060)


<h2>Предлагаем на выбор два задания со звёздочкой. Это по желанию. Верное решение задания со звёздочкой закрывает две ошибки в обязательных заданиях. Если правильно решить две задачи, то по-прежнему не засчитываются две ошибки в обязательной части.</h2>
<p><strong>*1</strong>. Сделать справочник клиентов. Посчитать возраст клиентов, разделить имя и фамилию на 2 отдельных поля;</p>
<p><strong>*2.</strong> Используя витрину в качестве табличного выражения или подзапроса, посчитайте количество транзакций по полю gender.</p>

<i>На проверку сдаётся файл с расширением .sql с пронумерованными запросами по каждому заданию. В качестве пояснений к решению рекомендуется оставлять комментарии к запросам.</i>
