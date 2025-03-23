class TransactionSerializer
  include JSONAPI::Serializer

  attributes :transaction_type, :amount, :status, :sender_id, :receiver_id
end
