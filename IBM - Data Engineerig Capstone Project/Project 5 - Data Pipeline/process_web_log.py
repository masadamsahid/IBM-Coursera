from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from datetime import timedelta, datetime


default_args = {
    'owner': 'Adam',
    'start_date': days_ago(0),
    'email': ['masadamsahid@gmail.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=1),
}

# DAG definition
dag = DAG(
    'process_web_log',
    default_args=default_args,
    description='Final Project of IBM Data Pipelines Using Apache AirFlow',
    schedule_interval=timedelta(days=1)
)


# Tasks
extract_data = BashOperator(
    task_id='extract_data',
    bash_command='cut -d" " -f1 /home/project/airflow/dags/capstone/accesslog.txt > /home/project/airflow/dags/capstone/extracted-data.txt',
    dag=dag,
    cwd=dag.folder
)

transform_data = BashOperator(
    task_id='transform_data',
    bash_command='grep -v "198.46.149.143" /home/project/airflow/dags/capstone/extracted-data.txt > /home/project/airflow/dags/capstone/transformed_data.txt',
    dag=dag,
    cwd=dag.folder
)

load_data = BashOperator(
    task_id='load_data',
    bash_command='tar cvf /home/project/airflow/dags/capstone/weblog.tar /home/project/airflow/dags/capstone/transformed_data.txt',
    dag=dag,
    cwd=dag.folder
)


# Pipeline
extract_data >> transform_data >> load_data
