if @install_stripe
  create_file 'docs/payments.md', <<~MARKDOWN
    # Stripe Payments

    ## Setup
    1. Add keys to `credentials.yml.enc`:
       ```yaml
       stripe:
         publishable_key: ...
         secret_key: ...
         signing_secret: ...
       ```
    2. **Webhooks**: Run `stripe listen --forward-to localhost:3000/webhooks/stripe`

    ## Architecture
    - `CheckoutsController`: Handles creating sessions.
    - `WebhooksController`: Handles `checkout.session.completed`.
  MARKDOWN
end
