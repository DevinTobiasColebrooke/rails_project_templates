if @install_active_storage || @install_action_text
  content = "# Content & Storage\n\n"

  if @install_active_storage
    content += <<~MARKDOWN
      ## Active Storage (File Uploads)

      Rails Active Storage facilitates uploading files to a cloud storage service (Amazon S3, Google Cloud Storage, or Microsoft Azure Storage) and attaching those files to Active Record objects.

      ### Key Files
      - **Config**: `config/storage.yml` (Define services like local, s3, azure).
      - **Environment**: `config/environments/*.rb` (Set `config.active_storage.service`).
      - **Database**: `active_storage_blobs`, `active_storage_attachments`, `active_storage_variant_records` tables.

      ### Setup
      1. **Local Development**: Defaults to `local` disk storage in `storage/`.
      2. **Production**:#{' '}
         - Open `config/storage.yml` and uncomment the provider you want (e.g., `amazon`).
         - Add required env vars (e.g., `AWS_ACCESS_KEY_ID`) to `credentials.yml.enc` or `.env`.
         - Set `config.active_storage.service = :amazon` in `config/environments/production.rb`.

      ### Usage

      **1. Attach a file to a model:**
      ```ruby
      class User < ApplicationRecord
        has_one_attached :avatar
        has_many_attached :documents
      end
      ```

      **2. Add input to form:**
      ```erb
      <%= form.file_field :avatar %>
      <%= form.file_field :documents, multiple: true %>
      ```

      **3. Displaying Images (with resizing):**
      Requires the `image_processing` gem (installed).
      ```erb
      <% if user.avatar.attached? %>
        <%= image_tag user.avatar.variant(resize_to_limit: [100, 100]) %>
      <% end %>
      ```
    MARKDOWN
  end

  if @install_action_text
    content += <<~MARKDOWN

      ## Action Text (Rich Text)

      Action Text brings rich text content and editing to Rails. It includes the **Trix** editor, which handles everything from formatting to links to quotes to lists to embedded images and galleries.

      ### Key Files
      - **JavaScript**: `app/javascript/controllers/application.js` (Loads Trix).
      - **CSS**: `app/assets/stylesheets/actiontext.css`.
      - **Database**: `action_text_rich_texts` table stores the HTML content.

      ### Usage

      **1. Add to Model:**
      ```ruby
      class Article < ApplicationRecord
        has_rich_text :content
      end
      ```
      *Note: You do not need a column in the `articles` table for content. It is stored in the separate `action_text_rich_texts` table.*

      **2. Add to Form:**
      ```erb
      <div class="field">
        <%= form.label :content %>
        <%= form.rich_text_area :content %>
      </div>
      ```

      **3. Render in View:**
      ```erb
      <div class="prose">
        <%= @article.content %>
      </div>
      ```

      ### Styling
      The Trix editor generates HTML with specific classes. You may need to style these classes or use a typography plugin (like Tailwind's `@tailwindcss/typography`) to make the rendered content look good.
    MARKDOWN
  end

  create_file 'docs/content_and_storage.md', content
end
