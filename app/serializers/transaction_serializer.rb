class TransactionSerializer
  include JSONAPI::Serializer

  attributes :transaction_type, :amount, :status, :perform_by_id, :receiver_id
end
