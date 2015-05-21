
## Keevahh -- Micro-lending is a powerful tool for social progress.

This application provides a hypothetical microlending platform where lenders
can connect with worthwhile projects from around the globe.

[Live Site: https://keevah.herokuapp.com](https://keevah.herokuapp.com)

[Skylight Monitoring](https://www.skylight.io/app/applications/DGW5zavnwBmL)

## Setup / Dependencies

* AWS S3 -- Uses Credentials in ENV vars `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `S3_BUCKET_NAME`
* Skylight.io -- Uses token in `SKYLIGHT_AUTHENTICATION` ENV variable
* Mandrill (SMTP API) -- Uses credentials in `MANDRILL_APIKEY` and `MANDRILL_USERNAME` ENV variables

The app includes a lengthy seed file for setting up sample data -- `rake db:seed`

### Testing

This application uses RSpec for its test suite. Tests can be run with `rake` or with `rspec`.

### Feature Overview

* Users register on the site as either a borrower (the business) or a lender (the customer)
* Borrowers automatically have a borrower page (the store)
* Within that borrower page, they post one or more loan requests (the products)
* A loan request has:
  * a title description, categories & photos
  * borrowing amount, requested-by date, a repayments-begin date, and a repayment rate
* A lender can browse the site and view all open loan requests
* They can add multiple loans from multiple borrowers to their cart
* They can then checkout and the funds are allocated to the borrowers
* The borrowers are notified that funding has come through and their loan request page is updated
