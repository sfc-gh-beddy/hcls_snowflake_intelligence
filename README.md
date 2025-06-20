# 🏥 Healthcare Intelligence Demo — Snowflake Cortex

This repository contains everything you need to replicate a robust **Healthcare Claims Assistant** using **Snowflake Cortex** — combining **structured healthcare data** with **unstructured claim PDFs** for Retrieval-Augmented Generation (RAG).

---

## ✅ **How to Use**

### 1️⃣ **Get the Data**

Download the **CSVs and claim PDFs** from the provided [Google Drive folder]([#](https://drive.google.com/drive/folders/1A_LEZSHNRxnrQjALUUxBt6UNRcA8HuoL?usp=sharing)).  
This includes:
- `patients.csv`, `claims.csv`, `providers.csv`, `appointments.csv`, `prescriptions.csv`
- `/pdfs` → `claim_1.pdf`, `claim_2.pdf`, etc.

---

### 2️⃣ **Upload Data to Snowflake**

- **Upload CSVs** → Create tables: `PATIENTS`, `CLAIMS`, `PROVIDERS`, `APPOINTMENTS`, `PRESCRIPTIONS`
- **Upload PDFs** → Create a named stage (e.g., `HEALTHCARE_DEMO_STAGE`) and upload all claim PDFs.

---

### 3️⃣ **Run the Notebook**

Open `healthcare_crotex_search.ipynb` in Snowsight **or** your preferred IDE:

- Parse PDFs into text.
- Split text into chunks.
- Create the `CLAIM_PDF_CHUNKS` table.
- Create the `CLAIM_PDF_CHUNKS_SEARCH_SERVICE`.

---

### 4️⃣ **Register the Semantic Model**

Go to Snowsight → **Semantic Models** → upload `healthcare_data.yaml`.

This connects your structured healthcare data to Cortex.

**Note: Have include sql to create semantic VIEW, if would rather demo that.**

---

### 5️⃣ **Create the Cortex Agent**

In Snowsight:
- Connect the **semantic model** `healthcare_data`.
- Attach the **search service** `CLAIM_PDF_CHUNKS_SEARCH_SERVICE`.
- Use `RELATIVE_PATH` as the **URL column**.
- Fill in orchestration instructions (provided in the Google Doc).

---

### 6️⃣ **Ask Questions!**

Try:
- “Explain claim ID 123 — what was diagnosed, how much was billed and paid?”
- “List patient name and key phrases for claim ID 456.”
- “Summarize the procedure and provider for claim ID 789.”

