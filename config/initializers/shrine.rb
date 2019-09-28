require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),
}

Shrine.plugin :activerecord # load integration for the Sequel ORM
Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :restore_cached_data # refresh metadata when attaching the cached file
Shrine.plugin :presign_endpoint