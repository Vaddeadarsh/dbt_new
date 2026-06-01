import pandas as pd

def model(dbt, session):
    # Load source table
    df = dbt.source("raw_mfg", "suppliers").to_pandas()

    # Standardize column names (uppercase → lowercase)
    df = df.rename(columns={
        "SUPPLIER_ID": "supplier_id",
        "NAME": "supplier_name",
        "EMAIL": "contact_email",
        "PHONE": "contact_phone",
        "COUNTRY": "country",
        "UPDATED_AT": "updated_at"
    })

    # Data cleaning
    df["supplier_id"] = pd.to_numeric(df["supplier_id"], errors="coerce")
    df["supplier_name"] = df["supplier_name"].astype(str).str.strip()
    df["contact_email"] = df["contact_email"].astype(str).str.strip()
    df["contact_phone"] = df["contact_phone"].astype(str).str.strip()
    df["country"] = df["country"].astype(str).str.strip()

    # Handle date → timestamp (important for snapshots/freshness)
    df["profile_updated_ts"] = pd.to_datetime(
        df["updated_at"], errors="coerce"
    )

    # Optional: remove invalid rows
    df = df.dropna(subset=["supplier_id"])

    # Select final columns
    df = df[
        [
            "supplier_id",
            "supplier_name",
            "contact_email",
            "contact_phone",
            "country",
            "profile_updated_ts"
        ]
    ]

    # Remove duplicates (best practice)
    df = df.drop_duplicates(subset=["supplier_id"])

    return session.create_dataframe(df)