# Tech Internship Aggregator & Email Notifier (LHR + FSD) — n8n Workflow

Automated workflow to **fetch**, **filter**, and **email** domain-specific internship alerts for **Lahore (LHR)** and **Faisalabad (FSD)** using **n8n** (no AI required).

---

## What This Does

- Pulls internship listings from **multiple sources** (e.g., Search API + LinkedIn parsing).
- **Normalizes** job data into a consistent structure.
- Filters internships strictly for:
  - **Locations:** Lahore (LHR), Faisalabad (FSD)
  - **Domains:** AI, ML, DL, CV, Data Science, Full Stack, Web Dev, DevOps, SQA
- Extracts important fields from the job text (when present):
  - **Work Type:** Remote / Hybrid / Onsite  
    - Includes logic to avoid false “Remote” cases like: *“remote not available”*.
  - **Stipend:** amount if mentioned, otherwise *Not Mentioned*
  - **Experience:** fresh graduate / entry-level / years required (if mentioned)
  - **Eligibility:** students/fresh graduates + degree hints (BSCS/BSIT/BSSE etc.) + skills
- Removes duplicates.
- Sends a clean **HTML email** per internship.

---

## Workflow Overview (High Level)

1. **Schedule Trigger** (runs daily or twice daily)
2. **Fetch Jobs** (Search API)
3. **Fetch LinkedIn Jobs** (HTML fetch + parsing)
4. **Normalize Data** (same fields for all sources)
5. **Combine Sources**
6. **Filter by City + Domain Titles/Keywords**
7. **Extract Details** (work type, stipend, experience, eligibility)
8. **Remove Duplicates**
9. **Send Email** (HTML template)

---

## Data Fields (Output)

Each internship email is generated from these fields:

- `title`
- `company`
- `location`
- `domain`
- `workType` (Remote / Hybrid / Onsite)
- `stipend` (amount if detected)
- `experience`
- `eligibility`
- `link`
- `trusted` (Verified Source / Verify Before Applying)

---

## Authenticity / Safety Filtering

The workflow attempts to remove obvious scam listings by filtering posts that contain suspicious patterns such as:
- registration fee / payment required
- “send money”
- “WhatsApp only”
- MLM / crypto trading type content

**Note:** No automated filter can guarantee 100% authenticity. Always verify on the company’s official page before applying.

---

## Setup Instructions (n8n)

### 1) Import Workflow
- In n8n, go to **Workflows → Import** and import the workflow JSON file (exported from your n8n instance).

### 2) Configure Credentials
- **Search API credential** (if used)
- **SMTP / Gmail App Password** for sending emails
  - Host: `smtp.gmail.com`
  - Port: `465`
  - SSL/TLS: enabled
  - Username: your Gmail
  - Password: Gmail **App Password** (not your normal password)

### 3) Set Email Settings
Update the **Send Email** node:
- From Email
- To Email
- Subject + HTML body

### 4) Set Schedule (Cron)
Recommended: twice daily (Pakistan time)
- **8:00 AM + 6:00 PM**
- Cron (n8n format with seconds):
  - `0 0 8,18 * * *`
- Timezone: `Asia/Karachi`

### 5) Test
- Click **Execute Workflow** to run manually.
- Check Inbox/Spam for results.

---

## Customization

### Add/Remove Domains
Update the filter lists in the **JavaScript Code node**:
- domain title variants
- domain keyword list

### Add More Cities
Update the `cities` array in the Code node.

### Improve Extraction Accuracy
Adjust the regex/keyword detection in:
- work type detection (remote/hybrid/onsite)
- stipend detection (PKR/Rs patterns)
- eligibility & degree parsing

---

## Example Email Fields (No Description Spam)

Emails include only the most useful summary:
- Title, company, location
- Work type
- Stipend
- Experience
- Eligibility
- Apply link
- Trusted source indicator

---

## Disclaimer

This project aggregates job listings from public sources.  
Always confirm internship authenticity and details on the official company/job portal before applying.  
Never pay any fee to apply for internships.

---

## License

MIT (or update as needed) Muhammad Numan Asghar, Peace out ❤
