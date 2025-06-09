;; Interview Coordination Contract
;; Coordinates hiring interviews between employers and talent

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_NOT_AUTHORIZED (err u400))
(define-constant ERR_INTERVIEW_NOT_FOUND (err u401))
(define-constant ERR_INVALID_STATUS (err u402))

;; Interview status constants
(define-constant INTERVIEW_SCHEDULED u1)
(define-constant INTERVIEW_COMPLETED u2)
(define-constant INTERVIEW_CANCELLED u3)

;; Data structures
(define-map interviews
  { interview-id: uint }
  {
    job-id: uint,
    talent-id: uint,
    employer-id: uint,
    scheduled-time: uint,
    duration-minutes: uint,
    status: uint,
    interview-type: (string-ascii 50), ;; "phone", "video", "in-person"
    notes: (string-ascii 500),
    rating: uint ;; 1-10 scale
  }
)

(define-data-var next-interview-id uint u1)

;; Public functions
(define-public (schedule-interview
  (job-id uint)
  (talent-id uint)
  (employer-id uint)
  (scheduled-time uint)
  (duration-minutes uint)
  (interview-type (string-ascii 50)))
  (let ((interview-id (var-get next-interview-id)))
    (map-set interviews
      { interview-id: interview-id }
      {
        job-id: job-id,
        talent-id: talent-id,
        employer-id: employer-id,
        scheduled-time: scheduled-time,
        duration-minutes: duration-minutes,
        status: INTERVIEW_SCHEDULED,
        interview-type: interview-type,
        notes: "",
        rating: u0
      }
    )
    (var-set next-interview-id (+ interview-id u1))
    (ok interview-id)
  )
)

(define-public (complete-interview (interview-id uint) (notes (string-ascii 500)) (rating uint))
  (match (map-get? interviews { interview-id: interview-id })
    interview-data
    (begin
      (asserts! (<= rating u10) ERR_INVALID_STATUS)
      (asserts! (>= rating u1) ERR_INVALID_STATUS)
      ;; In a real implementation, verify tx-sender is authorized
      (map-set interviews
        { interview-id: interview-id }
        (merge interview-data {
          status: INTERVIEW_COMPLETED,
          notes: notes,
          rating: rating
        })
      )
      (ok true)
    )
    ERR_INTERVIEW_NOT_FOUND
  )
)

(define-public (cancel-interview (interview-id uint))
  (match (map-get? interviews { interview-id: interview-id })
    interview-data
    (begin
      ;; In a real implementation, verify tx-sender is authorized
      (map-set interviews
        { interview-id: interview-id }
        (merge interview-data { status: INTERVIEW_CANCELLED })
      )
      (ok true)
    )
    ERR_INTERVIEW_NOT_FOUND
  )
)

(define-public (reschedule-interview (interview-id uint) (new-time uint))
  (match (map-get? interviews { interview-id: interview-id })
    interview-data
    (begin
      ;; In a real implementation, verify tx-sender is authorized
      (map-set interviews
        { interview-id: interview-id }
        (merge interview-data { scheduled-time: new-time })
      )
      (ok true)
    )
    ERR_INTERVIEW_NOT_FOUND
  )
)

;; Read-only functions
(define-read-only (get-interview (interview-id uint))
  (map-get? interviews { interview-id: interview-id })
)

(define-read-only (get-interview-status (interview-id uint))
  (match (map-get? interviews { interview-id: interview-id })
    interview-data (some (get status interview-data))
    none
  )
)

(define-read-only (is-interview-completed (interview-id uint))
  (match (map-get? interviews { interview-id: interview-id })
    interview-data (is-eq (get status interview-data) INTERVIEW_COMPLETED)
    false
  )
)
