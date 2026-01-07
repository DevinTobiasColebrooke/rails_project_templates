puts "\n💳  Payments"
@install_stripe = yes?("    Add Stripe Payments?")
if @install_stripe
  puts "    🔑  Stripe Configuration:"
  @stripe_publishable = fetch_config("        Publishable Key:", "TEMPLATE_STRIPE_PUB")
  @stripe_secret      = fetch_config("        Secret Key:", "TEMPLATE_STRIPE_SEC")
  @stripe_signing     = fetch_config("        Signing Secret (Webhook):", "TEMPLATE_STRIPE_SIGN")
end