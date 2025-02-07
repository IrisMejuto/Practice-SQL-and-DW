# Practice-SQL-y-DW
Repository for solving Advanced SQL and DW exercises, including ER diagram modeling, table creation, field calculations, and data cleaning functions.

## 1. Entity Relation Diagram
Create the entity-relationship diagram to model a database for Keepcoding, collecting data from students, bootcamps, modules, professors, etc.

A PDF with the diagram and a brief explanation of it must be submitted.

📝[Solution](https://github.com/IrisMejuto/Practice-SQL-y-DW/blob/main/1/KeepCoding%20Entity%20Relation%20Diagram.pdf)

## 2. Database Creation 
Develop a script to create the tables and necessary constraints according to the diagram provided in the previous step.
The script must be executable in PostgreSQL.

Submit the requested code in a `.sql` file.

📝[Solution](https://github.com/IrisMejuto/Practice-SQL-y-DW/blob/main/2/02_KeepCoding_DDBB_Creation.sql)

## 3. Create ivr_detail TABLE
We will create the data model for a customer service IVR.
From the files `ivr_calls`, `ivr_modules`, and `ivr_steps`, create the tables with the same names in the `keepcoding` dataset.

In `ivr_calls`, we find the data related to the calls.

In `ivr_modules`, we find data related to the different modules the call passes through. It relates to the `ivr_calls` table through the `ivr_id` field.

In `ivr_steps`, we find data about the steps the user takes within a module. It relates to the `ivr_modules` table through the `ivr_id` and `module_sequence` fields.
  
  We need the following fields:
  - calls_ivr_id
  - calls_phone_number
  - calls_ivr_result
  - calls_vdn_label
  - calls_start_date
  - calls_start_date_id
  - calls_end_date
  - calls_end_date_id
  - calls_total_duration
  - calls_customer_segment
  - calls_ivr_language
  - calls_steps_module
  - calls_module_aggregation
  - module_sequence
  - module_name
  - module_duration
  - module_result
  - step_sequence
  - step_name
  - step_result
  - step_description_error
  - document_type
  - document_identification
  - customer_phone
  - billing_account_id

The fields `calls_start_date_id` and `calls_end_date_id` are calculated date fields in the format `yyyymmdd`. For example, January 1, 2023, would be `20230101`.

Submit the SQL code that generates the `ivr_detail` table in a `.sql` file. The table should be created within the `keepcoding` dataset, and the project name should not appear in the query.

📝[Solution](https://github.com/IrisMejuto/Practice-SQL-y-DW/blob/main/3/03_table_ivr_detail.sql)

## 4. Generate vdn_aggregation field
Generate the field for each call. That is, we want to have the `calls_ivr_id` and `vdn_aggregation` fields with the following logic:
It is a generalization of the `vdn_label` field. If `vdn_label` starts with `ATC`, set `FRONT`; if it starts with `TECH`, set `TECH`; if it starts with `ABSORPTION`, set `ABSORPTION`; otherwise, set it as `RESTO`.

Submit the code in a `.sql` file.

📝[Solution](https://github.com/IrisMejuto/Practice-SQL-y-DW/blob/main/4/04_vdn_aggregation.sql)

## 5. Generate document_type and document_identification fields
Sometimes it is possible to identify the client in one of the `detail` steps by obtaining their document type and identification.

As in the previous exercise, we want to have one record per call and only one identified client for each call.

Submit the code in a `.sql` file.

📝[Solution]()

## 6. Generate customer_phone field
Sometimes it is possible to identify the client in one of the `detail` steps by obtaining their phone number.

As in the previous exercise, we want to have one record per call and only one identified client for each call.

Submit the code in a `.sql` file.

📝[Solution]()

## 7. Generate billing_account_id field
Sometimes it is possible to identify the client in one of the `detail` steps by obtaining their customer number.

As in the previous exercise, we want to have one record per call and only one identified client for each call.

Submit the code in a `.sql` file.

📝[Solution]()

## 8. Generate masiva_lg field
As in the previous exercise, we want to have one record per call and a flag indicating whether the call passed through the `AVERIA_MASIVA` module. If it did, mark it with `1`, otherwise set it to `0`.

Submit the code in a `.sql` file.

📝[Solution]()

## 9. Generate info_by_phone_lg field
As in the previous exercise, we want to have one record per call and a flag indicating whether the call passed through the step named `CUSTOMERINFOBYPHONE.TX` and its `step_result` is `OK`, meaning we were able to identify the customer by their phone number. In that case, set the flag to `1`, otherwise set it to `0`.

Submit the code in a `.sql` file.

📝[Solution]()

## 10. Generate info_by_dni_lg field
As in the previous exercise, we want to have one record per call and a flag indicating whether the call passed through the step named `CUSTOMERINFOBYDNI.TX` and its `step_result` is `OK`, meaning we were able to identify the customer by their DNI number. In that case, set the flag to `1`, otherwise set it to `0`.

Submit the code in a `.sql` file.

📝[Solution]()

## 11. Generate repeated_phone_24H, cause_recall_phone_24H fields
As in the previous exercise, we want to have one record per call and two flags indicating if the `calls_phone_number` had a call in the previous 24 hours or in the next 24 hours. If so, set these flags to `1`, otherwise set them to `0`.

Submit the code in a `.sql` file.

📝[Solution]()

## 12. CREATE ivr_summary TABLE (Extra credit)
Using the `ivr_detail` table and the code from all previous exercises, create the `ivr_summary` table. This will be a summary of the call, including the most important call indicators. Therefore, there will only be one record per call.

  We want the following fields:
  - ivr_id: Call identifier (from `detail`).
  - phone_number: Caller number (from `detail`).
  - ivr_result: Call result (from `detail`).
  - vdn_aggregation: Calculated earlier.
  - start_date: Call start date (from `detail`).
  - end_date: Call end date (from `detail`).
  - total_duration: Call duration (from `detail`).
  - customer_segment: Customer segment (from `detail`).
  - ivr_language: IVR language (from `detail`).
  - steps_module: Number of modules the call passes through (from `detail`).
  - module_aggregation: List of modules the call passes through (from `detail`).
  - document_type: Calculated earlier.
  - document_identification: Calculated earlier.
  - customer_phone: Calculated earlier.
  - billing_account_id: Calculated earlier.
  - masiva_lg: Calculated earlier.
  - info_by_phone_lg: Calculated earlier.
  - info_by_dni_lg: Calculated earlier.
  - repeated_phone_24H: Calculated earlier.
  - cause_recall_phone_24H: Calculated earlier.

Submit the SQL code that generates the `ivr_summary` table within the `keepcoding` dataset.

📝[Solution]()

## 13. Create clean_integer function
Create an integer cleaning function that returns the value `-999999` if a `NULL` is passed.

📝[Solution]()

Submit the SQL code that generates the `clean_integer` function within the `keepcoding` dataset.

📝[Solution]()
